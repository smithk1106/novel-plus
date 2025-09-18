import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

public class ReplaceEnv {
    public static void main(String[] args){
        if (args.length < 1) {
            System.out.println("Usage: java ReplaceEnv target_file");
            return;
        }

        String targetFile = args[0].trim();
        putLog("[i]Replace environments for " + targetFile);
        try {
            Path targetPath = Paths.get(targetFile);
            // Load text file
            String content = Files.readString(targetPath, StandardCharsets.UTF_8);

            // Replace environment variables
            int replaceCount= 0;
            Map<String, String> envMap = System.getenv();
            for (String key : envMap.keySet()) {
                String varName = "${" + key + "}";
                if (content.contains(varName)) {
                    content = content.replace(varName, envMap.get(key));
                    replaceCount++;
                }
            }

            // Save replaced text to file
            if (replaceCount > 0) {
                Files.writeString(targetPath, content, StandardCharsets.UTF_8);
            }

            putLog("[i]Finished. " + replaceCount + " variables was replaced.");
        } catch (IOException e) {
            putLog("[E]Failed because " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void putLog(String message) {
        Date now = Calendar.getInstance().getTime();
        String output = String.format("%s %s", (new SimpleDateFormat("yyyy-MM-dd hh:mm:ss")).format(now), message);
        System.out.println(output);
    }
}
