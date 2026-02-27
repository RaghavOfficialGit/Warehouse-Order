sap.ui.define([
    "sap/m/Shell",
    "sap/ui/core/ComponentContainer"
], function (Shell, ComponentContainer) {
    "use strict";

    // initialize the UI5 component and embed the component into the HTML document
    new Shell({
        showLogout: false,
        app: new ComponentContainer({
            height: "100%",
            name: "warehouse.order.app",
            settings: {
                id: "warehouse-order-app"
            }
        })
    }).placeAt("content");
});
