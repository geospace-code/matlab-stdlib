// Filesystem class usable from the command line
//
// useful to test Java functions before / while implementing in Matlab
//
// usage:
// % java Filesystem.java
//
// To install Java Development Kit (JDK): https://www.scivision.dev/install-jdk/

import java.util.Scanner;
import java.io.File;


public class Filesystem {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        String argument = "";
        final String prompt = "Jfs> ";

        System.out.print(prompt);

        while (scanner.hasNextLine()) {
            String input = scanner.nextLine();

            String[] inputArray = input.split(" ");
            String command = inputArray[0];

            if (inputArray.length > 1) {
                argument = inputArray[1];
            } else {
                argument = "";
            }

            if (command.equals("exit") || command.equals("q") || command.equals("\u0004")) {
                break;
            } else if (command.equals("java_version")) {
                System.out.println(System.getProperty("java.version"));
            } else if (command.equals("absolute")) {
                System.out.println(absolute(argument));
            } else if (command.equals("expanduser")) {
                System.out.println(expanduser(argument));
            } else if (command.equals("canonical")) {
                System.out.println(canonical(argument));
            } else if (command.equals("parent")) {
                System.out.println(parent(argument));
            } else if (command.equals("root")) {
                System.out.println(root(argument));
            } else if (command.equals("is_absolute")) {
                System.out.println(is_absolute(argument));
            } else if (command.equals("is_exe")) {
                System.out.println(is_exe(argument));
            } else if (command.equals("is_readable")) {
                System.out.println(is_readable(argument));
            } else if (command.equals("ram_free")) {
                System.out.println(ram_free());
            } else if (command.equals("cpu_count")) {
                System.out.println(cpu_count());
            } else if (command.equals("cpu_load")) {
                System.out.println(cpu_load());
            } else {
                System.err.println("Command not found");
            }

            System.out.print(prompt);
        }
    }

    public static String absolute(String path) {
        File f = new File(path);
        return f.getAbsolutePath();
    }

    public static String expanduser(String path) {
        if (path.startsWith("~"))
            return System.getProperty("user.home") + path.substring(1);

        return path;
    }

    public static String canonical(String path) {
        try {
            File p = new File(path);
            return p.getCanonicalPath();
        } catch (java.io.IOException e) {
            return path;
        }
    }

    public static Boolean is_absolute(String path) {
        return new File(path).isAbsolute();
    }

    public static Boolean is_exe(String path) {
        File f = new File(path);
        return f.isFile() && f.canExecute();
    }

    public static Boolean is_readable(String path) {
        return new File(path).canRead();
    }

    public static String parent(String path) {
        File f = new File(path);
        return f.getParent();
    }

    public static String root(String path) {
        File f = new File(path);
        return f.toPath().getRoot().toString();
    }

    public static Long ram_free() {
        com.sun.management.OperatingSystemMXBean os = (com.sun.management.OperatingSystemMXBean)
            java.lang.management.ManagementFactory.getOperatingSystemMXBean();
        return os.getFreeMemorySize();
    }

    public static int cpu_count() {
        com.sun.management.OperatingSystemMXBean os = (com.sun.management.OperatingSystemMXBean)
            java.lang.management.ManagementFactory.getOperatingSystemMXBean();
        return os.getAvailableProcessors();
    }

    public static double cpu_load() {
        com.sun.management.OperatingSystemMXBean os = (com.sun.management.OperatingSystemMXBean)
            java.lang.management.ManagementFactory.getOperatingSystemMXBean();
        return os.getCpuLoad();
    }
}
