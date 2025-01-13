global class ScheduleCancelBarbecueBudget implements Schedulable {
    global void execute(SchedulableContext SC) {
        CancelBarbecueBudgetsBatch batch = new CancelBarbecueBudgetsBatch();
        Database.executeBatch(batch);
    }
}