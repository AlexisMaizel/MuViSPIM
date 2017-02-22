//Generates TIFF stacks from HDF5
// Alexis Maizel
// May 20, 2016

//to do: read pixel size from .xml files and update properties
setBatchMode(true);

mainDir = getDirectory("Choose Input Directory");
mainOutputDir  = getDirectory("Choose output Directory");

Dialog.create("Create TIFF stacks from HDF5"); 
Dialog.addMessage("Enter output files name"); 
Dialog.addString("Default", "output");
Dialog.addMessage("Please select number of time steps to process"); 
Dialog.addString("Default", "1"); 
Dialog.addCheckbox("Left Camera used?", true); 
Dialog.addCheckbox("Right Camera used?", true);
Dialog.addCheckbox("Two channels?", true);
Dialog.show();
outputImageName = Dialog.getString();
MaxTimeStep = Dialog.getString(); 
useLeftCam = Dialog.getCheckbox(); 
useRightCam = Dialog.getCheckbox();
useTwoChannels = Dialog.getCheckbox();

channel0 = "stack_3_channel_3";
channel1 = "stack_3_channel_4";



for (time=0; time<MaxTimeStep; time++){

			t = IJ.pad(time,5); 
			
			if(useLeftCam){
				run("Scriptable load HDF5...", "load=["+mainDir+channel0+"/Cam_Left_"+t+".h5] datasetnames=/Data nframes=1 nchannels=1");
				saveAs("Tiff", mainOutputDir+outputImageName+"_Ch0_"+"CamL_T"+t+".tif");
				run("Close");
			}

			if(useRightCam){
				run("Scriptable load HDF5...", "load=["+mainDir+channel0+"/Cam_Right_"+t+".h5] datasetnames=/Data nframes=1 nchannels=1");
				saveAs("Tiff", mainOutputDir+outputImageName+"_Ch0_"+"CamR_T"+t+".tif");
				run("Close");
			}

			if(useTwoChannels){
				if(useLeftCam){
					run("Scriptable load HDF5...", "load=["+mainDir+channel1+"/Cam_Left_"+t+".h5] datasetnames=/Data nframes=1 nchannels=1");
					saveAs("Tiff", mainOutputDir+outputImageName+"_Ch1_"+"CamL_T"+t+".tif");
					run("Close");
				}

				if(useRightCam){
					run("Scriptable load HDF5...", "load=["+mainDir+channel1+"/Cam_Right_"+t+".h5] datasetnames=/Data nframes=1 nchannels=1");
					saveAs("Tiff", mainOutputDir+outputImageName+"_Ch1_"+"CamR_T"+t+".tif");
					run("Close");
				}
			}
			//force garbage collection
			call("java.lang.System.gc");
}
