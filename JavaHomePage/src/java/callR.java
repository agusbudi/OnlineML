/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


/**
 *
 * @author raharjo
 */
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

public class callR {
    
    private final String USER_AGENT = "Mozilla/5.0";

    public static void main(String[] args) throws Exception {

            callR http = new callR();
            
            System.out.println("Testing 1 - Send Http GET request");
            http.sendGet();

            byte [] coba = {2,4};
            System.out.println("\nTesting 2 - Send Http POST request");
            
//            String urlParameters = "a=6&b=4";
//            String URL = "http://localhost:8000/sum2";
            String folder = "/Users/raharjo/Downloads/oke/";
            
            String urlParameters ="folder="+ folder + "&conv=0.01&thres=0.8&ent=1";
            String URL = "http://localhost:8000/CRA";
       // this.result = executePost(targetURL, param);
                    
            System.out.println(http.excutePost(URL, urlParameters));
            
    }

    
    // HTTP GET request
    //source : https://www.mkyong.com/java/how-to-send-http-request-getpost-in-java/
    private void sendGet() throws Exception {
        
            String url = "http://localhost:8000/mean";

            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();

            // optional default is GET
            con.setRequestMethod("GET");

            //add request header
            con.setRequestProperty("User-Agent", USER_AGENT);

            int responseCode = con.getResponseCode();
            System.out.println("\nSending 'GET' request to URL : " + url);
            System.out.println("Response Code : " + responseCode);

            BufferedReader in = new BufferedReader(
                    new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
            }
            in.close();

            //print result
            System.out.println(response.toString());

    }
    
    
    // HTTP POST request
    //source: http://www.xyzws.com/Javafaq/how-to-use-httpurlconnection-post-data-to-web-server/139
    public static String excutePost(String targetURL, String urlParameters)
  {
    URL url;
    HttpURLConnection connection = null;  
    try {
      //Create connection
      url = new URL(targetURL);
      connection = (HttpURLConnection)url.openConnection();
      connection.setRequestMethod("POST");
      connection.setRequestProperty("Content-Type", 
           "application/x-www-form-urlencoded");
			
      connection.setRequestProperty("Content-Length", "" + 
               Integer.toString(urlParameters.getBytes().length));
      connection.setRequestProperty("Content-Language", "en-US");  
			
      connection.setUseCaches (false);
      connection.setDoInput(true);
      connection.setDoOutput(true);

      //Send request
      DataOutputStream wr = new DataOutputStream (
                  connection.getOutputStream ());
      wr.writeBytes (urlParameters);
      wr.flush ();
      wr.close ();

      //Get Response	
      InputStream is = connection.getInputStream();
      BufferedReader rd = new BufferedReader(new InputStreamReader(is));
      String line;
      StringBuffer response = new StringBuffer(); 
      while((line = rd.readLine()) != null) {
        response.append(line);
        response.append('\r');
      }
      rd.close();
      return response.toString();

    } catch (Exception e) {

      e.printStackTrace();
      return null;

    } finally {

      if(connection != null) {
        connection.disconnect(); 
      }
    }
  }
    
}
