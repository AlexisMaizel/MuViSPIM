//Generates TIFF stacks from HDF5
// Alexis Maizel


// Version change
// July 07 2016:
// = can now work with arbitrary number of channels

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
Dialog.addMessage("Number of channels to process"); 
Dialog.addString("Default", "2");
Dialog.show();
outputImageName = Dialog.getString();
MaxTimeStep = Dialog.getString(); 
useLeftCam = Dialog.getCheckbox(); 
useRightCam = Dialog.getCheckbox();
MaxNumOfChannels = Dialog.getString();

channel_root = "Stack_0_Channel_";



for (time=0; time<MaxTimeStep; time++){

			t = IJ.pad(time,5); 
			
	for (channel=0; channel<MaxNumOfChannels; channel++){			
				if(useLeftCam){
					run("Scriptable load HDF5...", "load=["+mainDir+channel_root+channel+"/Cam_Left_"+t+".h5] datasetnames=/Data nframes=1 nchannels=1");
					saveAs("Tiff", mainOutputDir+outputImageName+"_Ch"+channel+"_"+"CamL_T"+t+".tif");
					run("Close");
					}

				if(useRightCam){
					run("Scriptable load HDF5...", "load=["+mainDir+channel_root+channel+"/Cam_Right_"+t+".h5] datasetnames=/Data nframes=1 nchannels=1");
					saveAs("Tiff", mainOutputDir+outputImageName+"_Ch"+channel+"_"+"CamR_T"+t+".tif");
					run("Close");
					}
				}
	}
			//force garbage collection
			call("java.lang.System.gc");

Dialog.create("Finished..."); 
