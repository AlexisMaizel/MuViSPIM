//Generates MIPs from HDF5
// Alexis Maizel
// January 28, 2016

setBatchMode(true);

mainDir = getDirectory("Choose Input Directory");
mainOutputDir  = getDirectory("Choose output Directory");

Dialog.create("Create MIP from HDF5"); 
Dialog.addMessage("Enter output files name"); 
Dialog.addString("Default", "MIP");
Dialog.addMessage("Number of time steps to process"); 
Dialog.addString("Default", "1"); 
Dialog.addCheckbox("Process Left Camera?", true); 
Dialog.addCheckbox("Process Right Camera?", true);
Dialog.addString("Number of channels (max 3)", "1"); 
Dialog.show();
outputImageName = Dialog.getString();
MaxTimeStep = Dialog.getString(); 
useLeftCam = Dialog.getCheckbox(); 
useRightCam = Dialog.getCheckbox();
NumberOfChannels = Dialog.getString();

channel0 = "Stack_0_Channel_0";
channel1 = "Stack_0_Channel_1";
channel2 = "Stack_0_Channel_2";


for (time=0; time<MaxTimeStep; time++){

			t = IJ.pad(time,5); 
			
			if(useLeftCam){
				run("Scriptable load HDF5...", "load=["+mainDir+channel0+"/Cam_Left_"+t+".h5] datasetnames=/Data nframes=1 nchannels=1");
				run("Z Project...", "start=1 stop="+nSlices+" projection=[Max Intensity]");
				saveAs("Tiff", mainOutputDir+outputImageName+"_Ch0_"+"CamL_T"+t+".tif");
				run("Close");
				run("Close");
			}

			if(useRightCam){
				run("Scriptable load HDF5...", "load=["+mainDir+channel0+"/Cam_Right_"+t+".h5] datasetnames=/Data nframes=1 nchannels=1");
				run("Z Project...", "start=1 stop="+nSlices+" projection=[Max Intensity]");
				saveAs("Tiff", mainOutputDir+outputImageName+"_Ch0_"+"CamR_T"+t+".tif");
				run("Close");
				run("Close");
			}

			if(NumberOfChannels >1){
				if(useLeftCam){
					run("Scriptable load HDF5...", "load=["+mainDir+channel1+"/Cam_Left_"+t+".h5] datasetnames=/Data nframes=1 nchannels=1");
					run("Z Project...", "start=1 stop="+nSlices+" projection=[Max Intensity]");
					saveAs("Tiff", mainOutputDir+outputImageName+"_Ch1_"+"CamL_T"+t+".tif");
					run("Close");
					run("Close");
				}

				if(useRightCam){
					run("Scriptable load HDF5...", "load=["+mainDir+channel1+"/Cam_Right_"+t+".h5] datasetnames=/Data nframes=1 nchannels=1");
					run("Z Project...", "start=1 stop="+nSlices+" projection=[Max Intensity]");
					saveAs("Tiff", mainOutputDir+outputImageName+"_Ch1_"+"CamR_T"+t+".tif");
					run("Close");
					run("Close");
				}
				if(NumberOfChannels == 3){
					if(useLeftCam){
						run("Scriptable load HDF5...", "load=["+mainDir+channel2+"/Cam_Left_"+t+".h5] datasetnames=/Data nframes=1 nchannels=1");
						run("Z Project...", "start=1 stop="+nSlices+" projection=[Max Intensity]");
						saveAs("Tiff", mainOutputDir+outputImageName+"_Ch2_"+"CamL_T"+t+".tif");
						run("Close");
						run("Close");
					}

					if(useRightCam){
						run("Scriptable load HDF5...", "load=["+mainDir+channel2+"/Cam_Right_"+t+".h5] datasetnames=/Data nframes=1 nchannels=1");
						run("Z Project...", "start=1 stop="+nSlices+" projection=[Max Intensity]");
						saveAs("Tiff", mainOutputDir+outputImageName+"_Ch2_"+"CamR_T"+t+".tif");
						run("Close");
						run("Close");
					}	
				}
			}
			//force garbage collection
			run("Collect Garbage");
}
