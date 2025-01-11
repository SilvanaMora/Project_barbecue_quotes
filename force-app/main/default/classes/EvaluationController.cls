public with sharing class EvaluationController {

    // Método para obtener el estado del asado
    @AuraEnabled(cacheable=true)
    public static Barbecue_Budget__c getBarbecueStatus(Id barbecueId) {
        return [SELECT Status__c FROM Barbecue_Budget__c WHERE Id = :barbecueId LIMIT 1];
    }

    // Método para guardar la evaluación
    @AuraEnabled
    public static void saveEvaluation(Id barbecueId, Integer score, String observations) {
        Evaluation__c evaluation = new Evaluation__c(
            Barbecue_Budget__c = barbecueId,
            Score__c = score,
            Observations__c = observations
        );
        insert evaluation;
    }
}