// add npgsql from download
using System;
//using Npgsql;


namespace ConstructionManagement
{
    internal class Program
{
        static void Main(string[] args)
        {
            Console.WriteLine("Starting application...");
            if(Initialise()) //check to initialise data successfully
            {
                //screen selection
            }
            else //program was not able to run
            {
                //open file for error handling / update

                //write report

                //close file

                //close program
                return;
            }

           

        }

        //run database on startup, or potential
        static bool Initialise()
        {
            return true;
        }
    
}
}