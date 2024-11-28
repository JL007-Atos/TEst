Updates to be done for new project usage

Config file
1) Update OrchestratorQueueFolder from BRIDGE to IDM_Bridge in Settings after moving to Prod
2) Update Project settings in Constants sheet sa per your project requirement
3) In Assets, do not remove/change Name for Developer, EndUser & EndUserCC, only update the Asset column and OrchestratorAssetFolder to IDM_Bridge when moving to Prod
4) No update in Data sheet

Workfolder folder
1) Module1 & 2 are added for your convenience, just rename them and add your activities in Try sequence & update your ErrorMsg in exception so if it fails, you will know when and where it has failed
2) You can invoke SendErrorEmail.xaml anywhere in your workflow to debug it, just need to assign the error text to ErrorMsg argument to get clear picture on what the error is. If you are invoking it in try catch exception, assign exception.ToString to ErrorMsg
3) If you wish to terminate any of your workflow as per your requirement, please add Terminate workflow activity in the try catch exception after SendErrorEmail is invoked
4) RerunCheck - If you have multiple triggers in Orchestrator, you can add this as the 1st step in Process, it'll check if there was any previous execution which was successful by checking successful sent emails from Outlook, otherwise, it'll proceed to run the workflow.

PSScript folder
If you have any SNow report to download, read the ReadMe file. This script will take 2-10 seconds to download report depending on data