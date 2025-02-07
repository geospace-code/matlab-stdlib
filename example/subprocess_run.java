import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

public class Filesystem {
    public static void main(String[] argv) {
try {

ProcessBuilder builder = new ProcessBuilder(argv[0]);
Process process = builder.start();

BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
String line;
while ((line = reader.readLine()) != null) {
    System.out.println(line);
}


BufferedReader errorReader = new BufferedReader(new InputStreamReader(process.getErrorStream()));
while ((line = errorReader.readLine()) != null) {
    System.err.println(line);
}

int exitCode = process.waitFor();
System.out.println("Process exited with code: " + exitCode);

process.destroy();

} catch (IOException | InterruptedException e) {
// ignore
}

}

}
