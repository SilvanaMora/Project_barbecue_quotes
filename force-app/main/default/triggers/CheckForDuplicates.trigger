trigger CheckForDuplicates on Budget_Item__c (before insert, before update) {
    // Crear un mapa para almacenar los presupuestos y productos a validar
    Map<Id, Set<Id>> budgetProductMap = new Map<Id, Set<Id>>();

    // Recorrer los registros que están siendo insertados o actualizados
    for (Budget_Item__c item : Trigger.new) {
        if (item.Barbecue_Budget__c != null && item.Product__c != null) {
            // Si ya existe un conjunto para el presupuesto, añadir el producto
            if (!budgetProductMap.containsKey(item.Barbecue_Budget__c)) {
                budgetProductMap.put(item.Barbecue_Budget__c, new Set<Id>());
            }
            budgetProductMap.get(item.Barbecue_Budget__c).add(item.Product__c);
        }
    }

    // Consultar los artículos existentes en los presupuestos afectados
    List<Budget_Item__c> existingItems = [
        SELECT Barbecue_Budget__c, Product__c
        FROM Budget_Item__c
        WHERE Barbecue_Budget__c IN :budgetProductMap.keySet()
    ];

    // Verificar duplicados
    for (Budget_Item__c existingItem : existingItems) {
        if (budgetProductMap.containsKey(existingItem.Barbecue_Budget__c) &&
            budgetProductMap.get(existingItem.Barbecue_Budget__c).contains(existingItem.Product__c)) {
            for (Budget_Item__c newItem : Trigger.new) {
                if (newItem.Barbecue_Budget__c == existingItem.Barbecue_Budget__c &&
                    newItem.Product__c == existingItem.Product__c) {
                    // Agregar un mensaje de error al registro duplicado
                    newItem.addError('El producto ya existe en este presupuesto de asado.');
                }
            }
        }
    }
}