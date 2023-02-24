package action.item;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;
/*
 * 플라스크 통신 테스트 코드
 */
public class FlaskApiClient {

    public static void main(String[] args) {
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create("http://192.168.0.146:5000/recommandItem?item_id=0&cosine_weight=3")) 
            .header("Content-Type", "application/json")
            .GET()
            .build();

        try {
            HttpResponse<String> response = client.send(request, BodyHandlers.ofString());
            String responseBody = response.body();
            System.out.println(responseBody);
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}