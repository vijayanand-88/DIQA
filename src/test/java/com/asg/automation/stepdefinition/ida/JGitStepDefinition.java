package com.asg.automation.stepdefinition.ida;

import com.asg.automation.utils.DataLoader;
import com.asg.automation.utils.FileUtil;
import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.utils.RepoData;
import com.asg.automation.wrapper.JGitWrapper;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import org.apache.commons.lang3.RandomStringUtils;
import org.eclipse.jgit.util.FileUtils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Sivanandam.Meiya on 7/5/2017.
 */
public class JGitStepDefinition extends JGitWrapper {
    RepoData repoData;

    @Before("@JGIT")
    public void beforeScenario() throws Exception {
        propLoader.loadProperty();
        FileUtil.createDirectory(propLoader.prop.getProperty("Clonedirectory"));
        Thread.sleep(5000);

    }


    @And("^New file has been created in local git and committed\\.$")
    public void new_file_has_been_created_in_local_git_and_committed() {
        try {
            String dynamicFileName = "DynamicFile_" + RandomStringUtils.randomAlphanumeric(3) + ".txt";
            createfile(dynamicFileName);
            commit("File added");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "New file has been created in remote repository");
            List<String> files = new ArrayList<String>();
            files.add(dynamicFileName);
            DataLoader.getDataLoaderInstance().getRepoData().setFiles(files);
            DataLoader.getDataLoaderInstance().getRepoData().setRepoFileCount(files.size());
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "New file is not created in remote repository");
        }


    }

    @Given("^A File has been deleted from bitbucket repository and committed$")
    public void a_File_has_been_deleted_from_bitbucket_repository_and_committed() {
        try {
            deleteFile();
            commit("File Deleted");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "File has been deleted from remote repository");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "File is not deleted from remote repository");
        }

    }


    @Given("^A File name has been modified in bitbucket repository and committed$")
    public void a_File_name_has_been_modified_in_bitbucket_repository_and_committed() {

        try {
            String dynamicFileName = "RenamedFile_" + RandomStringUtils.randomAlphanumeric(3) + ".txt";
            renameFile(dynamicFileName);
            commit("File Name Modified");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "File name  modified and committed");
            List<String> files = new ArrayList<String>();
            files.add(dynamicFileName);
            DataLoader.getDataLoaderInstance().getRepoData().setFiles(files);
            DataLoader.getDataLoaderInstance().getRepoData().setRepoFileCount(files.size());
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "File name not modified");
        }

    }


    @Then("^Changes pushed to \"([^\"]*)\" repository\\.$")
    public void Changes_pushed_to_repository(String remoteRepository) {
        try {
            push(remoteRepository);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Changes are pushed to " + remoteRepository);
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Changes are not pushed to " + remoteRepository);
        }


    }

    @Given("^Clone remote repository \"([^\"]*)\" repository to \"([^\"]*)\"$")
    public void clone_remote_repository_repository_to(String remoteRepository, String localSystemDirectory) {
        try {
            cloneRepository(remoteRepository, localSystemDirectory);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), remoteRepository + " is cloned to local user directory " + localSystemDirectory);
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), remoteRepository + " is not cloned to local user directory " + localSystemDirectory);
        }
    }


    @Given("^New \"([^\"]*)\" and New \"([^\"]*)\" has been created$")
    public void new_and_New_has_been_created(String directoryName, String fileName) {
        try {
            createDirectoryAndFile(directoryName, fileName);
            commit("Folder created and file added inside newly created folder");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "New Folder has been created with a file");
            List<String> files = new ArrayList<String>();
            files.add(fileName);
            DataLoader.getDataLoaderInstance().getRepoData().setFiles(files);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "New Folder is not created");
        }
    }

    @Given("^Existing \"([^\"]*)\"name  has been modified to \"([^\"]*)\"\\.$")
    public void existing_name_has_been_modified_to(String existingDirectory, String newDirectoryName) {
        try {
            renameDirectory(existingDirectory, newDirectoryName);
            commit("Folder Renamed");
            List<String> directoryName = new ArrayList<String>();
            directoryName.add(newDirectoryName);
            DataLoader.getDataLoaderInstance().getRepoData().setFiles(directoryName);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Folder Name has been modified");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Folder Name has been modified");
        }


    }

    @Given("^\"([^\"]*)\" and its content has been deleted\\.$")
    public void and_its_content_has_been_deleted(String deletingPath) {
        try {
            deleteDirectory(deletingPath);
            commit("Folder Renamed");
            List<String> directoryName = new ArrayList<String>();
            directoryName.add(deletingPath);
            DataLoader.getDataLoaderInstance().getRepoData().setFiles(directoryName);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Folder has been deleted");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Folder is not deleted");
        }

    }

    @Given("^user modify \"([^\"]*)\" content in \"([^\"]*)\" directory\\.$")
    public void user_modify_content_in_directory(String fileName, String path) {
        try {
            modifyFileContent(fileName, path);
            commit("File Content modified");
            LoggerUtil.logLoader_info(this.getClass().getName(), "File content modified");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "File content not modified");
        }

    }

    @Given("^user create \"([^\"]*)\" files in \"([^\"]*)\" directory$")
    public void user_create_files_in_directory(String noOfFiles, String path) {
        try {
            createMultipleFiles(noOfFiles, path);
            commit("Multiple Files created");
            LoggerUtil.logLoader_info(this.getClass().getName(), "Multiple files created");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Multiple files  not created");
        }

    }

    @Given("^user modify the file names in \"([^\"]*)\" directory$")
    public void user_modify_the_file_names_in_directory(String path) {
        try {
            modifyFileNames(path);
            commit("File names modified");
            LoggerUtil.logLoader_info(this.getClass().getName(), "File names modified");
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getName(), "File names not modified");
        }


    }

    @Given("^user delete the files from \"([^\"]*)\" directory\\.$")
    public void user_delete_the_files_from_directory(String path) {

    }

    @Given("^user delete the local cloned directory$")
    public void user_delete_the_local_cloned_directory() throws Throwable {
//      deleteLocalRepoDirectory();
        tearDown();
    }
}
