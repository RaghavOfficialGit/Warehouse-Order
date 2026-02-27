# Warehouse Order Management CAP Project

This project demonstrates a CAP (Cloud Application Programming Model) application that integrates with an external OData service to expose Warehouse Order data through a custom service with a UI5 frontend.

## Architecture

- **CAP Service**: Node.js-based service that consumes external OData service
- **External Service**: API_HUB destination for Warehouse Order OData service
- **UI5 Application**: Fiori Elements-based frontend for viewing warehouse orders
- **Security**: XSUAA authentication with role-based access control

## Project Structure

```
warehouse-order/
├── srv/
│   ├── warehouse-order-service.cds    # Main service definition
│   ├── warehouse-order-service.js     # Service implementation
│   └── external/
│       └── API_HUB.cds                # External service model
├── app/
│   ├── index.html                     # App entry point
│   ├── manifest.json                  # UI5 app manifest
│   ├── ui5-deploy.xml                 # Deployment configuration
│   ├── xs-app.json                    # App router configuration
│   ├── view/                          # UI5 views
│   │   ├── WarehouseOrdersList.view.xml
│   │   └── WarehouseOrderObjectPage.view.xml
│   └── i18n/
│       └── i18n.properties            # Text resources
├── db/                                # Database schema (if needed)
├── xs-security.json                   # Security configuration
├── mta.yaml                           # Multi-target application
└── package.json                       # Node.js dependencies
```

## Features

### CAP Service Features
- **External Service Integration**: Consumes Warehouse Order OData service from API_HUB destination
- **Entity Projection**: Exposes WarehouseOrder, WarehouseTask, and WarehouseOrderPickHndlgUnit entities
- **Custom Actions**: 
  - `getWarehouseOrderDetails`: Get complete order details with tasks and handling units
  - `getWarehouseOrdersByStatus`: Filter orders by status
- **Logging**: Comprehensive logging for monitoring and debugging

### UI5 Application Features
- **Fiori Elements**: List Report and Object Page for warehouse orders
- **Smart Filtering**: Filter by warehouse, order number, status, and processor
- **Responsive Design**: Works on desktop, tablet, and mobile devices
- **Navigation**: Seamless navigation between list and detail views
- **Internationalization**: Multi-language support (i18n)

## Prerequisites

- Node.js 18+ 
- SAP Cloud Foundry CLI
- SAP BTP account with:
  - XSUAA service
  - Destination service
  - HANA database (optional)

## Setup Instructions

### 1. Local Development

```bash
# Install dependencies
npm install

# Start the CAP server
npm run watch
```

### 2. Destination Configuration

Configure the `API_HUB` destination in your BTP subaccount with:
- **Name**: API_HUB
- **URL**: Your Warehouse Order OData service URL
- **Authentication**: Appropriate authentication method (OAuth, Basic, etc.)

### 3. Deploy to Cloud Foundry

```bash
# Build the MTA archive
npm run build

# Deploy to Cloud Foundry
npm run deploy
```

## API Endpoints

### Service Endpoints
- **Warehouse Orders**: `GET /odata/v4/WarehouseOrderExt/WarehouseOrders`
- **Warehouse Tasks**: `GET /odata/v4/WarehouseOrderExt/WarehouseTasks`
- **Handling Units**: `GET /odata/v4/WarehouseOrderExt/WarehouseOrderPickHndlgUnits`

### Custom Actions
- **Order Details**: `POST /odata/v4/WarehouseOrderExt/getWarehouseOrderDetails`
- **Orders by Status**: `POST /odata/v4/WarehouseOrderExt/getWarehouseOrdersByStatus`

## Security Roles

The application defines three security roles:
- **WarehouseOrderViewer**: Read-only access
- **WarehouseOrderEditor**: Read and edit access
- **WarehouseOrderAdmin**: Full administrative access

## Configuration

### Environment Variables
- `API_HUB_URL`: External API URL (optional if using destination)
- `LOG_LEVEL`: Logging level (default: info)

### Service Configuration
Update `.cdsrc.json` to modify:
- External service configuration
- Database settings
- OData version settings

## Development Notes

### Adding New Entities
1. Update `srv/external/API_HUB.cds` with new entity definitions
2. Add projections in `srv/warehouse-order-service.cds`
3. Implement custom logic in `srv/warehouse-order-service.js`
4. Update UI5 views to display new data

### Custom UI Controls
The UI5 application uses Fiori Elements templates. For custom logic:
- Extend controllers in the view files
- Add custom actions to the service
- Update manifest.json for new routes

## Troubleshooting

### Common Issues
1. **Destination Not Found**: Ensure API_HUB destination is properly configured
2. **Authentication Errors**: Check XSUAA configuration and role assignments
3. **CORS Issues**: Verify destination configuration allows cross-origin requests

### Logging
Check application logs for debugging:
- Local: Console output
- Cloud Foundry: `cf logs warehouse-order-srv --recent`

## Support

For issues and questions:
1. Check the troubleshooting section
2. Review Cloud Foundry logs
3. Verify destination configuration
4. Check XSUAA role assignments

## License

This project is provided as-is for demonstration purposes.
