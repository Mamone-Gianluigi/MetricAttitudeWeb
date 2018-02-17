
import java.util.ArrayList;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;

public class ProgectJSON {

	public static int i = 0;

	public static void scansiona(File dir) throws IOException {

		// RADICE-NOME PROGETTO
		JSONObject obj = new JSONObject();
		obj.put("id", i);
		obj.put("text", dir.getName());
		obj.put("icon","./images/radice.png");
		
		i = i + 1;

		// LISTA FIGLI PROGETTO
		JSONArray list = new JSONArray();
		File[] elementi = dir.listFiles();
		ArrayList<File> directory = new ArrayList<>();
		ArrayList<File> filee = new ArrayList<>();

		// ORDINE DELLE DIRECTORY DEL PROGETTO : CARTELLE E POI FILE
		for (File fi : elementi) {
			if (fi.isDirectory())
				directory.add(fi);
			else if (fi.isFile())
				filee.add(fi);
		}

		// AGGIUNTA FIGLI (CARTELLE) DEL PROGETTO- QUANDO SI INCONTRA SRC SI
		// EFFETTUA LA RICORSIONE
		for (File file : directory) {
			JSONObject objdir = new JSONObject();
			objdir.put("id", i);
			objdir.put("text", file.getName());
		
			list.add(objdir);
			i = i + 1;
			if (file.getName().equals("src")) {
				// SCANSIONE DI SRC
				File fileSrc = new File(dir.getAbsolutePath() + "\\src");
				System.out.println(fileSrc.getPath());

				JSONArray listSr = scansioneSrc(fileSrc);
				objdir.put("children", listSr);

			}

		}
		// AGGIUNTA FIGLI (FILE) DEL PROGETTO
		for (File file : filee) {
			JSONObject objdir = new JSONObject();
			objdir.put("id", i);
			objdir.put("text", file.getName());
			objdir.put("icon", "jstree-file");
			System.out.println(file.getName());
			list.add(objdir);
			i = i + 1;
		}

		obj.put("children", list);

		JSONArray listt = new JSONArray();
		listt.add(obj);

		// CREAZIONE DEL FILE JSON
		try {
			FileOutputStream fileJson = new FileOutputStream(dir.getPath() + "\\"+dir.getName()+".json");
		} catch (IOException e) {
			System.out.println("Errore: " + e);
			System.exit(1);
		}

		try (FileWriter file1 = new FileWriter(dir.getPath() + "\\"+dir.getName()+".json")) {
			file1.write(listt.toJSONString());
			file1.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}

		System.out.print(listt.toJSONString());

		return;

	}

	public static JSONArray scansioneSrc(File dir) {

		JSONArray list = new JSONArray();
		File[] element = dir.listFiles();
		if (element == null) {
			return null;
		}

		ArrayList<File> dirr = new ArrayList<>();
		ArrayList<File> fill = new ArrayList<>();
		for (File fi : element) {
			if (fi.isDirectory())
				dirr.add(fi);
			else if (fi.isFile())
				fill.add(fi);
		}
		dirr.addAll(fill);

		for (File fil : dirr) {
			JSONObject objfile = new JSONObject();
			objfile.put("id", i);
			objfile.put("text", fil.getName());
			i = i + 1;
			if (fil.isFile()) {
				
				objfile.put("icon", "./images/iconJava.png");
				list.add(objfile);
				System.out.println(fil.getName());
			} else if (fil.isDirectory()) {
				objfile.put("icon","./images/packJava.png");
				list.add(objfile);
				File fileSrc = new File(fil.getAbsolutePath());
				JSONArray listSrs = scansioneSrc(fileSrc);
				objfile.put("children", listSrs);

			}

		}

		return list;
	}

}