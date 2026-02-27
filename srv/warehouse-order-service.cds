using { API_HUB as external } from '../db/external/API_HUB';

service WarehouseOrderExt {
    
    @readonly
    entity WarehouseOrders as projection on external.WarehouseOrder {
        key EWMWarehouse,
        key WarehouseOrder,
        WarehouseOrderStatus,
        WhseOrderCreationDateTime,
        WarehouseOrderStartDateTime,
        WhseOrderConfirmedDateTime,
        WhseOrderLastChgUTCDateTime,
        WhseOrderLatestStartDateTime,
        WarehouseOrderCreationRule,
        WhseOrderCreationRuleCategory,
        ActivityArea,
        Queue,
        Processor,
        ExecutingResource,
        WhseProcessTypeDocumentHdr,
        CreatedByUser,
        LastChangedByUser,
        ConfirmedByUser,
        WhseOrderForSplitWhseOrder,
        WarehouseOrderIsSplit,
        WarehouseOrderPlannedDuration,
        WhseOrderPlanDurationTimeUnit
    };

    @readonly
    entity WarehouseTasks as projection on external.WarehouseTask {
        key EWMWarehouse,
        key WarehouseTask,
        WarehouseOrder,
        WarehouseTaskItem,
        WarehouseTaskStatus,
        WhseTaskCrtnUTCDateTime,
        WhseTaskLastChgUTCDateTime,
        WhseTaskConfUTCDateTime,
        WhseTaskPlannedClosingDateTime,
        WhseTaskGoodsReceiptDateTime,
        Product,
        ProductDescription,
        QuantityInBaseUnit,
        BaseUnit,
        EntryUnit,
        QuantityInEntryUnit,
        SourceStorageBin,
        DestinationStorageBin,
        _WarehouseOrder : redirected to WarehouseOrders
    };

    @readonly
    entity WarehouseOrderPickHndlgUnits as projection on external.WarehouseOrderPickHndlgUnit {
        key EWMWarehouse,
        key WarehouseOrder,
        key HandlingUnitExternalID,
        PackagingMaterial,
        EWMWhseOrderNmbrOfHndlgUnits,
        _WarehouseOrder : redirected to WarehouseOrders
    };
}
