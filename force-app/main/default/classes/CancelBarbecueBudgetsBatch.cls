public with sharing class CancelBarbecueBudgetsBatch implements Database.Batchable<SObject>, Database.Stateful {

    public Database.QueryLocator start(Database.BatchableContext BC) {
        // Consulta para obtener los presupuestos de asado que no hayan tenido lugar en la fecha prevista
        String query = 'SELECT Id, Status__c, Start__c, End__c FROM Barbecue_Budget__c WHERE End__c < TODAY AND Status__c != \'Completado\'';
        System.debug('query: ' + query);
        return Database.getQueryLocator(query);
    }

    // Método para actualizar los presupuestos de asado a 'Cancelado'
    public void execute(Database.BatchableContext BC, List<Barbecue_Budget__c> scope) {
        for (Barbecue_Budget__c budget : scope) {
            budget.Status__c = 'Cancelado';
        }
        update scope;
    }

    public void finish(Database.BatchableContext BC) {
        
    }
}