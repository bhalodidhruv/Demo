public with sharing class TestController {
    public String country{get; set;}
    public String city{get; set;}
    public String disabled{get; set;}

    public Boolean getIsDisabled() {
        return 'Y'.equals(disabled);
    }
    public PageReference test() {
        return null;
    }

    public List<SelectOption> getYesNo() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Y','Yes')); 
        options.add(new SelectOption('N','No')); 
        return options; 
    }

    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('US','US')); 
        options.add(new SelectOption('CANADA','Canada')); 
        options.add(new SelectOption('MEXICO','Mexico')); return options; 
    }
}