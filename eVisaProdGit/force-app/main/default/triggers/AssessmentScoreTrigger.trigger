trigger AssessmentScoreTrigger on assessment__c (before insert) {
    if(trigger.isInsert && trigger.isBefore){
        LeadAssessmentCalculator.calcPoints(trigger.new);
    }
}