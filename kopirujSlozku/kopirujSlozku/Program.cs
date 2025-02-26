using System;
using System.IO;

namespace FolderCopy
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                string filePath = "C:\\makro\\BC_input.txt";
                string mainDestinationFolder = "C:\\zaloha";

                if (!File.Exists(filePath))
                {
                    Console.WriteLine("The configuration file does not exist.");
                    return;
                }

                string[] lines = File.ReadAllLines(filePath);
                if (lines.Length < 2)
                {
                    Console.WriteLine("The configuration file does not contain the required information.");
                    return;
                }

                string sourceFolder = lines[1].Trim();

                if (!Directory.Exists(sourceFolder))
                {
                    Console.WriteLine($"Source folder does not exist: {sourceFolder}");
                    return;
                }

                string sourceFolderName = new DirectoryInfo(sourceFolder).Name;
                string destinationFolder = Path.Combine(mainDestinationFolder, sourceFolderName);

                CopyDirectory(sourceFolder, destinationFolder);

                Console.WriteLine($"Copied contents from {sourceFolder} to {destinationFolder}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred: {ex.Message}");
            }
        }

        static void CopyDirectory(string sourceDir, string destinationDir)
        {
            Directory.CreateDirectory(destinationDir);

            foreach (string filePath in Directory.GetFiles(sourceDir))
            {
                string destFilePath = Path.Combine(destinationDir, Path.GetFileName(filePath));
                File.Copy(filePath, destFilePath, true);
            }

            foreach (string dirPath in Directory.GetDirectories(sourceDir))
            {
                string destDirPath = Path.Combine(destinationDir, Path.GetFileName(dirPath));
                CopyDirectory(dirPath, destDirPath);
            }
        }
    }
}
