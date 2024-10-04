package util;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

public class TokenManager {
    private static final Map<String, TokenInfo> tokens = new ConcurrentHashMap<>();

    // Generate token and store it with expiration time
    public static String generateToken(String email) {
        String token = UUID.randomUUID().toString();
        LocalDateTime expirationTime = LocalDateTime.now().plus(5, ChronoUnit.MINUTES); // 5 minutes
        tokens.put(token, new TokenInfo(email, expirationTime));
        return token;
    }

    // Validate if the token exists and has not expired
    public static boolean isValidToken(String token) {
        TokenInfo tokenInfo = tokens.get(token);
        if (tokenInfo == null) {
            return false; // Token does not exist
        }
        LocalDateTime currentTime = LocalDateTime.now();
        if (tokenInfo.getExpirationTime().isBefore(currentTime)) {
            tokens.remove(token); // Remove expired token
            return false; // Token expired
        }
        return true; // Token is valid
    }

    // Get email associated with the token
    public static String getEmailByToken(String token) {
        TokenInfo tokenInfo = tokens.get(token);
        if (tokenInfo != null) {
            return tokenInfo.getEmail();
        }
        return null;
    }

    // TokenInfo class to hold email and expiration time
    private static class TokenInfo {
        private final String email;
        private final LocalDateTime expirationTime;

        public TokenInfo(String email, LocalDateTime expirationTime) {
            this.email = email;
            this.expirationTime = expirationTime;
        }

        public String getEmail() {
            return email;
        }

        public LocalDateTime getExpirationTime() {
            return expirationTime;
        }
    }

    public static void main(String[] args) throws InterruptedException {
        String token = TokenManager.generateToken("riotgame902@gmail.com");
        System.out.println(TokenManager.getEmailByToken(token));
        System.out.println("Token valid after creation: " + TokenManager.isValidToken("60f3e669-85a5-4d27-9403-18fc7a65cd2c"));
    }
}
