namespace warehouse.order.db;

using { cuid, managed } from '@sap/cds/common';

// Define Warehouse Order entity for local storage/cache
entity WarehouseOrders : cuid, managed {
    key EWMWarehouse            : String(4);
    key WarehouseOrder          : String(10);
    WarehouseOrderStatus        : String(2);
    WhseOrderCreationDateTime   : DateTimeOffset;
    WarehouseOrderStartDateTime : DateTimeOffset;
    WhseOrderConfirmedDateTime  : DateTimeOffset;
    WhseOrderLastChgUTCDateTime : DateTimeOffset;
    WhseOrderLatestStartDateTime: DateTimeOffset;
    WarehouseOrderCreationRule  : String(4);
    WhseOrderCreationRuleCategory: String(2);
    ActivityArea                : String(4);
    Queue                       : String(6);
    Processor                   : String(12);
    ExecutingResource           : String(18);
    WhseProcessTypeDocumentHdr  : String(4);
    CreatedByUser               : String(12);
    LastChangedByUser           : String(12);
    ConfirmedByUser             : String(12);
    WhseOrderForSplitWhseOrder  : String(10);
    WarehouseOrderIsSplit       : Boolean;
    WarehouseOrderPlannedDuration: Decimal(15, 2);
    WhseOrderPlanDurationTimeUnit: String(3);
    
    // Relationships
    tasks       : Composition of many WarehouseTasks on tasks.parentOrder_ID = $self.ID;
    handlingUnits: Composition of many WarehouseOrderPickHndlgUnits on handlingUnits.parentOrder_ID = $self.ID;
    
    // Additional fields for caching and synchronization
    lastSyncAt  : DateTimeOffset;
    isActive    : Boolean default true;
}

// Define Warehouse Task entity for local storage/cache
entity WarehouseTasks : cuid, managed {
    key EWMWarehouse                  : String(4);
    key WarehouseTask                 : String(10);
    WarehouseOrder                    : String(10);
    WarehouseTaskItem                 : String(4);
    WarehouseTaskStatus               : String(2);
    WhseTaskCrtnUTCDateTime           : DateTimeOffset;
    WhseTaskLastChgUTCDateTime        : DateTimeOffset;
    WhseTaskConfUTCDateTime           : DateTimeOffset;
    WhseTaskPlannedClosingDateTime    : DateTimeOffset;
    WhseTaskGoodsReceiptDateTime      : DateTimeOffset;
    Product                           : String(40);
    ProductDescription                : String(40);
    QuantityInBaseUnit                : Decimal(15, 3);
    BaseUnit                          : String(3);
    EntryUnit                         : String(3);
    QuantityInEntryUnit               : Decimal(15, 3);
    SourceStorageBin                  : String(18);
    DestinationStorageBin             : String(18);
    
    // Relationship to parent order
    parentOrder_ID : UUID;
    parentOrder    : Association to one WarehouseOrders on parentOrder.ID = parentOrder_ID;
    
    // Additional fields for caching and synchronization
    lastSyncAt    : DateTimeOffset;
    isActive      : Boolean default true;
}

// Define Warehouse Order Pick Handling Unit entity for local storage/cache
entity WarehouseOrderPickHndlgUnits : cuid, managed {
    key EWMWarehouse                : String(4);
    key WarehouseOrder              : String(10);
    key HandlingUnitExternalID      : String(20);
    PackagingMaterial               : String(40);
    EWMWhseOrderNmbrOfHndlgUnits    : String(3);
    
    // Relationship to parent order
    parentOrder_ID : UUID;
    parentOrder    : Association to one WarehouseOrders on parentOrder.ID = parentOrder_ID;
    
    // Additional fields for caching and synchronization
    lastSyncAt    : DateTimeOffset;
    isActive      : Boolean default true;
}

// Configuration entity for external service settings
entity ExternalServiceConfig : cuid, managed {
    key serviceName    : String(50);
    destinationName    : String(50);
    lastSyncAt         : DateTimeOffset;
    syncIntervalMinutes: Integer default 30;
    isActive           : Boolean default true;
    configuration      : LargeString; // JSON configuration
}

// Audit log entity for tracking data changes
entity AuditLogs : cuid, managed {
    entityName      : String(50);
    entityKey       : String(255);
    operation       : String(20); // CREATE, UPDATE, DELETE, SYNC
    oldValues       : LargeString; // JSON of old values
    newValues       : LargeString; // JSON of new values
    changedBy       : String(50);
    changeTimestamp : DateTimeOffset;
    source          : String(20); // EXTERNAL_API, USER_ACTION, SYSTEM
}

// User preferences entity
entity UserPreferences : cuid, managed {
    key userId        : String(50);
    defaultWarehouse : String(4);
    defaultQueue     : String(6);
    preferredStatus  : String(2);
    uiSettings       : LargeString; // JSON of UI preferences
    isActive         : Boolean default true;
}
