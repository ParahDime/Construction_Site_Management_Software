// add npgsql from download
using System;
//using Npgsql;


namespace ConstructionManagement
{
    internal class Program
{
        static bool Initialise()
        {
            return true;
        }


        static void ErrorHandling(string absolutePath, string errorMessage)
        {
            try
            {
                //creates a file if not existing
                string directory = Path.GetDirectoryName(absolutePath);
                if (!string.IsNullOrEmpty(directory) && !Directory.Exists(directory))
                {
                    Directory.CreateDirectory(directory);
                }

                using (StreamWriter writer = new StreamWriter(absolutePath, true)) //true appends the data, false if needed to overwrite
                {
                    string logLine = $"[{DateTime.Now:yyyy-MM-dd HH:mm:ss}] ERROR: {errorMessage}";

                    writer.WriteLine(logLine);

                    // The 'using' block automatically flushes (saves) and closes the file stream safely here.
                }
            }
            catch (Exception ex) //logging file error may itself have an error
            {

                System.Diagnostics.Debug.WriteLine($"Failed to write to log file: {ex.Message}");
            }
        }

        static void RegisterServices()
        {

        }
        static void RegisterViewModels()
        {
            //load and register in all viewmodels needed
        }

        static void StartUp()
        {
            //handoff to app.xaml
        }

        static void Main(string[] args)
        {
            //handles any error handling
            string filePath = "" + ".txt";
            string errorMessage = "error";

            Console.WriteLine("Starting application...");
            if(Initialise()) //check to initialise data successfully
            {
                Console.WriteLine("Data loaded successfully");
                Console.WriteLine("Initialising...");
                //initialise data (DI, configuration, logs

                RegisterServices();
                //load in any repos

                RegisterViewModels();
                StartUp();
                //screen selection
            }
            else //program was not able to run
            {
                ErrorHandling(filePath, errorMessage);
                return;
            }
            return;
        }   
}
}