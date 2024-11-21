package Models;

import java.io.BufferedWriter;
import java.io.IOException;

public class DataProcessor {
    private int dataCount = 0;
    private BufferedWriter writer;

    public void InitializeProcess(){
        boolean isProcessing = true;
        if(dataCount == 0 || !isProcessing){
            System.out.println("No Data to Process");
        }
    }

    public void writeData(String data){
        if(data == null || data.isEmpty()){
            return;
        } try{
            writer.write(data);
        }catch (IOException e){
            System.out.println("Error Writing Data" + e.getMessage());
        }
    }

    public void closeWriter(){
        try {
            writer.close();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public void processData(){
        InitializeProcess();
        if(dataCount > 100){
            System.out.println("eufyeguwye");
            return;
        }

    }
    public void shutdown(){
        writer = null;
    }
}
