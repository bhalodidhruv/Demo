@RestResource(urlMapping='/v1/SOEN341/*')
global class SOEN341_Project
{

    
   @HttpGet
    global static string doGet()
    {
       return 'yo yo';
    }
}