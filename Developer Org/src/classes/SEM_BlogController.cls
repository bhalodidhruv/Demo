public class SEM_BlogController {

   public Map<String,Question> questionMap {get;set;}

   public String message {get;set;}

   private String emailId;

   

   //constructor

   public SEM_BlogController(){

       questionMap = new Map<String,Question>();

       emailId = 'demo@gmail.com';

       populateChartData();

   }

   public void populateChartData() {

       Question que;

       List<chartDataWrapper> data;

       chartDataWrapper chartData;

       for(Integer i = 0 ; i < 5 ; i++){

           data = new List<chartDataWrapper>();

           for(Integer j = 0 ; j < 3 ; j++){

               chartData = new chartDataWrapper('ans' + j,  j + 8);

               data.add(chartData);

           }

           que = new Question();

           que.question = 'Demo Question ' + i + '?';

           que.chartData = data;

           questionMap.put(que.question,que);

       }

   }

   

    public void sendEmail(){

       

       String body = Apexpages.currentPage().getParameters().get('pdfContent');

       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

       String[] toAddresses = new String[]{emailId};

       

           mail.setToAddresses(toAddresses);

           mail.setSubject('Demo PDF');

           mail.setPlainTextBody('Hi, PFB the sample PDF file.');

           mail.setBccSender(false);

           mail.setUseSignature(false);

           mail.saveAsActivity = false;

           body = body.replace('https://c.cs83.visual.force.com/', '');

           // Add to attachment file list

           List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();

           Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();

           efa.setFileName('demo.pdf');

           efa.setBody(EncodingUtil.base64Decode(body));

           fileAttachments.add(efa);

           mail.setFileAttachments(fileAttachments);

           //Send email

           

           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

           message = 'Email has been send successfully!';

   }

 

// Wrapper class

   public class chartDataWrapper {

 

       public String name { get; set; }

       public Integer data { get; set; }

 

       public chartDataWrapper(String name, Integer data) {

           this.name = name;

           this.data = data;

       }

   }

   public class Question{

       public String question {get;set;}

       public List<chartDataWrapper> chartData {get;set;}

   }

}