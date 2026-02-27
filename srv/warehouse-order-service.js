const cds = require('@sap/cds');
const logger = cds.log('WarehouseOrderService');

class WarehouseOrderService extends cds.ApplicationService {
    async init() {
        
        this.after('READ', 'WarehouseOrders', (data) => {
            if (data) {
                logger.info(`Read ${Array.isArray(data) ? data.length : 1} warehouse orders`);
            }
        });

        this.after('READ', 'WarehouseTasks', (data) => {
            if (data) {
                logger.info(`Read ${Array.isArray(data) ? data.length : 1} warehouse tasks`);
            }
        });

        this.on('getWarehouseOrderDetails', async (req) => {
            const { EWMWarehouse, WarehouseOrder } = req.data;
            
            try {
                const order = await SELECT.one.from('WarehouseOrders')
                    .where({ EWMWarehouse, WarehouseOrder });
                
                if (!order) {
                    return req.reject(404, 'Warehouse Order not found');
                }

                const tasks = await SELECT.from('WarehouseTasks')
                    .where({ EWMWarehouse, WarehouseOrder });

                const handlingUnits = await SELECT.from('WarehouseOrderPickHndlgUnits')
                    .where({ EWMWarehouse, WarehouseOrder });

                return {
                    order,
                    tasks,
                    handlingUnits
                };
            } catch (error) {
                logger.error('Error fetching warehouse order details:', error);
                return req.reject(500, 'Internal server error');
            }
        });

        this.on('getWarehouseOrdersByStatus', async (req) => {
            const { status } = req.data;
            
            try {
                const orders = await SELECT.from('WarehouseOrders')
                    .where({ WarehouseOrderStatus: status });
                
                return orders;
            } catch (error) {
                logger.error('Error fetching warehouse orders by status:', error);
                return req.reject(500, 'Internal server error');
            }
        });

        await super.init();
    }
}

module.exports = WarehouseOrderService;
