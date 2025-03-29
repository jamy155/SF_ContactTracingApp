public with sharing class CTStatusUpdateSchedule implements Schedulable {
    // TODO: add schedulable apex class to clear locations and people records every day at 2am.
    public static final String CRON = '0 0 2 * * ?';
    
    public void execute(SchedulableContext sc) {
       CTUpdatePersonStatusBatch updatePersonStatusBatch = new CTUpdatePersonStatusBatch();
      Database.executeBatch(updatePersonStatusBatch, 2000);
    }

}