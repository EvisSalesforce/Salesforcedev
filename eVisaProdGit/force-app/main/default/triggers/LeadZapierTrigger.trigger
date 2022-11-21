trigger LeadZapierTrigger on Lead (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        LeadZapierTriggerHandler.ConvertLeadFromZapier(trigger.new);
    }
}