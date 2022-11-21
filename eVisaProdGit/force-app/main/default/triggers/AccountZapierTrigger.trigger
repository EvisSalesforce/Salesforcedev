trigger AccountZapierTrigger on Account (after insert, after update) {
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
        AccountZapierTriggerHandler.CreateConsultationFromZapier(trigger.new);
    }
}