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
import java.nio.file.Path;


public class Filesystem {
    public static void main(String[] argv) {
        Scanner scanner = new Scanner(System.in);

        String a1 = "";
        String a2 = "";
        final String prompt = "Jfs> ";

        System.out.print(prompt);

        while (scanner.hasNextLine()) {
            String input = scanner.nextLine();

            String[] args = input.split(" ");
            String command = args[0];

            if (args.length > 1) {
                a1 = args[1];
            }
            if (args.length > 2) {
                a2 = args[2];
            }

            if (command.equals("exit") || command.equals("q") || command.equals("\u0004")) {
                break;
            } else if (command.equals("java_version")) {
                System.out.println(System.getProperty("java.version"));
            } else if (command.equals("absolute")) {
                System.out.println(absolute(a1));
            } else if (command.equals("create_symlink")) {
                System.out.println(create_symlink(a1, a2));
            } else if (command.equals("expanduser")) {
                System.out.println(expanduser(a1));
            } else if (command.equals("canonical")) {
                System.out.println(canonical(a1));
            } else if (command.equals("parent")) {
                System.out.println(parent(a1));
            } else if (command.equals("root")) {
                System.out.println(root(a1));
            } else if (command.equals("is_absolute")) {
                System.out.println(is_absolute(a1));
            } else if (command.equals("is_exe")) {
                System.out.println(is_exe(a1));
            } else if (command.equals("is_file")) {
                System.out.println(new File(a1).isFile());
            } else if (command.equals("is_readable")) {
                System.out.println(is_readable(a1));
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

    public static Boolean create_symlink(String target, String link) {
        Path t = new File(target).toPath();
        Path l = new File(link).toPath();
        try {
            java.nio.file.Files.createSymbolicLink(l, t);
            return true;
        } catch (java.io.IOException e) {
            System.err.println(e);
            return false;
        }
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
        return f.canExecute();
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
