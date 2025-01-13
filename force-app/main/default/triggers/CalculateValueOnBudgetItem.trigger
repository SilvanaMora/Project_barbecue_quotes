trigger CalculateValueOnBudgetItem on Budget_Item__c (before insert, before update) {
    // Recopilar los IDs de productos relacionados
    Set<Id> productIds = new Set<Id>();

    for (Budget_Item__c item : Trigger.new) {
        if (item.Product__c != null) {
            productIds.add(item.Product__c);
        }
    }

    // Consultar datos de productos
    Map<Id, Product2> productMap = new Map<Id, Product2>(
        [SELECT Id, Service__c, Product_value__c FROM Product2 WHERE Id IN :productIds]
    );

    // Consultar precios de servicios desde los metadatos
    Map<String, Decimal> servicePriceMap = new Map<String, Decimal>();
    for (Service_price_table__mdt servicePrice : [
        SELECT Service_mtd__c, Value_per_hour_of_service__c FROM Service_price_table__mdt
    ]) {
        servicePriceMap.put(servicePrice.Service_mtd__c, servicePrice.Value_per_hour_of_service__c);
    }

    // Calcular el valor de cada partida presupuestaria
    for (Budget_Item__c item : Trigger.new) {
        if (item.Product__c != null && productMap.containsKey(item.Product__c)) {
            Product2 product = productMap.get(item.Product__c);

            if (product.Service__c != null && servicePriceMap.containsKey(product.Service__c)) {
                // Calcular para servicios
                Decimal valorPorHora = servicePriceMap.get(product.Service__c);
                item.Barbecue_Budget__r = [SELECT Id, Start__c, End__c FROM Barbecue_Budget__c WHERE Id = :item.Barbecue_Budget__c];
                System.debug('Valor por hora: ' + valorPorHora);
                System.debug('Barbecue_Budget__r: ' + item.Barbecue_Budget__r);
                //traer Barbecue_Budget del item con soql
                
                if (valorPorHora != null && item.Barbecue_Budget__r != null && item.Barbecue_Budget__r.Start__c != null && item.Barbecue_Budget__r.End__c != null) {
                    // Calculamos la duración en horas redondeando hacia arriba
                   Long startTime = item.Barbecue_Budget__r.Start__c.getTime();
                    Long endTime = item.Barbecue_Budget__r.End__c.getTime();
                    if (startTime != null && endTime != null) {
                        Decimal duracionEvento = Math.ceil(
                            (endTime - startTime) / (1000 * 60 * 60)
                        );
                        item.Item_value__c = item.Quantity__c * duracionEvento * valorPorHora;
                        
                    } else {
                        
                    }
                } else {
                   
                }
            } else if (product.Product_value__c != null) {
                // Calcular para productos
                item.Item_value__c = item.Quantity__c * product.Product_value__c;
                System.debug('Item_value__c calculado para producto: ' + item.Item_value__c);
            } else {
                System.debug('Product_value__c es nulo');
            }
        } else {
            System.debug('Product__c es nulo o no está en productMap');
        }
    }
}