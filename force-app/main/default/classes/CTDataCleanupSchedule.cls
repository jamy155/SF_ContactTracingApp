public with sharing class CTDataCleanupSchedule implements Schedulable {
    // TODO: add schedulable apex class to clear locations and people records every day at 2am.
    public static final String CRON = '0 0 2 * * ?';
    
    public void execute(SchedulableContext sc) {
        CTPeopleTracingDataCleanUpBatch peopleTracingBatch = new CTPeopleTracingDataCleanUpBatch();
        Database.executeBatch(peopleTracingBatch, 2000);


        CTLocationTracingDataCleanUpBatch locationTracingBatch = new CTLocationTracingDataCleanUpBatch();
        Database.executeBatch(locationTracingBatch, 2000);
    }

}