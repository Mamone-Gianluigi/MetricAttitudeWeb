package parsing;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Utils {

	private static boolean _debug = false;
	private static int id = 1;

	public static void setDebug(boolean debug) {
		_debug = debug;
	}

	public static int getId() {
		return id++;
	}

	public static void print(String message) {

		boolean multiple = message.contains("\n");
		String format = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss.SSS")
				.format(new Timestamp(new java.util.Date().getTime()));

		if (multiple) {
			System.out.println("[" + format + "] " + Constants.appAcro + ":[");
			System.out.println(message);
			System.out.println("[" + format + "] " + Constants.appAcro + ":]");

		} else
			System.out.println("[" + format + "] " + Constants.appAcro + ":: " + message);
	}

	public static void print(Exception e) {
		print("ERROR: " + e.getMessage());
		if (_debug)
			e.printStackTrace();
	}

}
