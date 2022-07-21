
	Electrode Reconstruction Widget for Neuroimaging (ERWiN)
=========================================================================

This GUI widget was created to help locate stereo-EEG contact locations.

To start: open Matlab and run ERWiN in the command line 
(ensure the folder containing the ERWiN.m file has been added to your 
list of paths).

The ERWiN function will open the GUI needed to run all electrode contact 
location estimations. Once all parameters are successfully entered and 
contact coordinates are created, the "Done" button is enabled and will 
allow to save all outputs.


Current Version: 0.7
Updated on: 	 21/07/2022
__________________________________________________________________________
Current Version Updates:
       - GUI created that allows i-EEG electrode location estimation based
         on the deepest contact's position and a second contact position
         placed on the electrode's shaft.
         Required parameters for each electrode are Name, Number of
         Contacts, Distance Between Contacts (mm), Deepest Contact's
         Coordinates, Second Contact Coordinates.
       - "Snapping", when enabled, searches for the voxel with the highest
         intensity in a 2x2x2 volumetric kernel (to more accurately place 
         the electrode's contact).
       - A T1 file may also be loaded to anatomically compare electrode 
         locations with patient's pre-implantation scan (optional).
       - Glassbrain is a graphical output that displays located electrodes
         and a mesh of the CT (and/or T1) volume.
       - AutoUpdate from Github fix.
       - Rotation and permutation buttons added.
       - Output .mgrids may be viewed in BioImage Suite 3.0
       - Fixed bug wrgds to color assignment
       - Deletes old Children of Parent axes when new volume loaded
       - Axes directions updated for axial and sagittal planes
       - Electrode vis. feedback when estimation successful
       - Reset view button added (when viewer starts malfunctioning)
       - New exporting window makes file saving more streamlined
       - Autosave and possibility of loading autosaved files (*_erwin.mat)
       - Electrode name bug fixed
       - Order contacts are saved in .mgrid reversed for correct
         BioImageSuite reading
          
       Note: electrode parameters may only be modified or updated in the
       CT tab. After updating any electrode parameters, estimation must be
       re-run in order to update contact locations. At this point, only
       depth electrodes may be created (no grids or strips).

Known bugs:
       - Glassbrain tab requires major work.
       - 3-slice viewer functional but may be optimised by displaying
         transpose of loaded volume.
 
Future Version Updates:
       - Add option to not save Mgrid file.
       - Add option to save .txt file compatible with final BioImageSuite
         output file.
       - Review 3-slice viewer displaying method.
       - Add option to create "grid" electrodes.
       - Add option to create "strip" electrodes.

__________________________________________________________________________

Created by J.P.Monney - Human Neuron Lab (Université de Genève)
https://www.unige.ch/medecine/neucli/en/groupes-de-recherche/1034megevand/

Contact: jonathan.monney@unige.ch
___________________________________________________________________________
