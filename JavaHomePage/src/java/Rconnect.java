
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 *
 * @author raharjo
 */
public class Rconnect {
    
    private final String result;
    public Rconnect(String folder, String convergence, String threshold, String entro){

        String urlParameters ="folder="+ folder + "&conv=0.1&thres=0.65&ent=0.5";
        String URL = "http://localhost:8000/CRA";    
        String res = executePost(URL, urlParameters);
        res = res.replace("\"","");
        res = res.replace("[","");
        res = res.replace("]","");
        res = res.replace("\r","");
        
        this.result = res;
    }
    
    // HTTP POST request
    private String executePost(String targetURL, String param)
    {
        String X, Y, algo, prediction;

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
                 Integer.toString(param.getBytes().length));
        connection.setRequestProperty("Content-Language", "en-US");  

        connection.setUseCaches (false);
        connection.setDoInput(true);
        connection.setDoOutput(true);

          try ( //Send request
                  DataOutputStream wr = new DataOutputStream (
                          connection.getOutputStream ())) {
              wr.writeBytes (param);
              wr.flush ();
          }

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

    /**
     * @return the result
     */
    public String getResult() {
        return result;
    }
}
