@cds.persistence.exists

entity WarehouseOrder : managed {
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
    SAP__Messages               : Array of String;
}

entity WarehouseTask : managed {
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
    _WarehouseOrder : Association to one WarehouseOrder on _WarehouseOrder.EWMWarehouse = $self.EWMWarehouse and _WarehouseOrder.WarehouseOrder = $self.WarehouseOrder;
}

entity WarehouseOrderPickHndlgUnit : managed {
    key EWMWarehouse                : String(4);
    key WarehouseOrder              : String(10);
    key HandlingUnitExternalID      : String(20);
    PackagingMaterial               : String(40);
    EWMWhseOrderNmbrOfHndlgUnits    : String(3);
    _WarehouseOrder : Association to one WarehouseOrder on _WarehouseOrder.EWMWarehouse = $self.EWMWarehouse and _WarehouseOrder.WarehouseOrder = $self.WarehouseOrder;
}
