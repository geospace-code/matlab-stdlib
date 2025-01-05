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
import java.nio.file.Paths;
import java.nio.file.attribute.BasicFileAttributes;
import java.nio.file.attribute.DosFileAttributes;
import java.nio.file.LinkOption;


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
            } else if (command.equals("is_reparse_point")) {
                System.out.println(is_reparse_point(a1));
            } else if (command.equals("is_writable")) {
                System.out.println(is_writable(a1));
            } else if (command.equals("is_symlink")) {
                System.out.println(is_symlink(a1));
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

    public static boolean is_windows() {
        return System.getProperty("os.name").toLowerCase().contains("windows");
    }

    public static boolean create_symlink(String target, String link) {
        Path t = Paths.get(target);
        Path l = Paths.get(link);
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

    public static boolean is_absolute(String path) {
        return new File(path).isAbsolute();
    }

    public static boolean is_exe(String path) {
        File f = new File(path);
        return f.canExecute();
    }

    public static boolean is_readable(String path) {
        return new File(path).canRead();
    }

    public static boolean is_writable(String path) {
        return new File(path).canWrite();
    }

    public static boolean is_symlink(String path) {
        Path p = Paths.get(path);
        return java.nio.file.Files.isSymbolicLink(p);
    }

    public static boolean is_reparse_point(String path) {
// https://github.com/openjdk/jdk/blob/master/src/java.base/windows/classes/sun/nio/fs/WindowsFileAttributes.java
// reflection to access WindowsFileAttributes
// https://stackoverflow.com/a/29647840
        if (!is_windows()) {
            return false;
        }

        Path p = Paths.get(path);
        try {
            BasicFileAttributes attrs = java.nio.file.Files.readAttributes(p, BasicFileAttributes.class, LinkOption.NOFOLLOW_LINKS);
            if (DosFileAttributes.class.isInstance(attrs)) {
                java.lang.reflect.Method m = attrs.getClass().getDeclaredMethod("isReparsePoint");
                m.setAccessible(true);
                return (boolean) m.invoke(attrs);
            }
        } catch (Exception e) {
            System.err.println(e);
            System.err.println("Try running with --add-opens java.base/sun.nio.fs=ALL-UNNAMED");
        }
        return false;
    }


    public static String parent(String path) {
        File f = new File(path);
        return f.getParent();
    }

    public static String root(String path) {
        Path r = Paths.get(path).getRoot();
        if (r == null) {
            return "";
        }
        return r.toString();
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
