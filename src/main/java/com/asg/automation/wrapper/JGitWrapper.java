package com.asg.automation.wrapper;


import com.asg.automation.utils.FileUtil;
import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.utils.PropertyLoader;
import org.apache.commons.io.FileUtils;
import org.apache.geode.redis.internal.executor.transactions.ExecExecutor;
import org.eclipse.jgit.api.AddCommand;
import org.eclipse.jgit.api.CloneCommand;
import org.eclipse.jgit.api.Git;
import org.eclipse.jgit.api.errors.GitAPIException;
import org.eclipse.jgit.internal.storage.file.WindowCache;
import org.eclipse.jgit.lib.Repository;
import org.eclipse.jgit.revwalk.RevCommit;
import org.eclipse.jgit.storage.file.FileRepositoryBuilder;
import org.eclipse.jgit.storage.file.WindowCacheConfig;
import org.eclipse.jgit.transport.UsernamePasswordCredentialsProvider;
import org.openqa.selenium.interactions.Actions;
import org.testng.Assert;


import java.io.File;
import java.io.IOException;
import java.util.logging.Logger;

import static org.eclipse.jgit.util.FileUtils.delete;

/**
 * This is a wrapper class to perform GIT operations
 */
public class JGitWrapper {

    private Git git;
    private Git localRepo;
    static File localclonedir;
    private Repository Workingdirectory;
    protected PropertyLoader propLoader;
    protected Repository Repo;
    CloneCommand cloneCommand = Git.cloneRepository();
    Git openlocaldirectory;
    private static final Logger LOG = Logger.getLogger(Actions.class.getName());

    public JGitWrapper() {
        propLoader = new PropertyLoader();

    }


    /**
     * This method is used to clone the repository
     *
     * @param remoteRepository the name of the repo
     * @throws GitAPIException GitAPIException
     * @throws IOException     IOException
     */

    public void cloneRepository(String remoteRepository, String localSystemDirectory) throws GitAPIException, IOException {

        localclonedir = new File(propLoader.prop.getProperty("Clonedirectory") + "\\" + localSystemDirectory);
        try {
            WindowCacheConfig config = new WindowCacheConfig();
            config.setPackedGitMMAP(false);
            WindowCache.reconfigure(config);
            if (!localclonedir.exists()) {
                LOG.info("\n Cloning remote repository");
                cloneCommand.setURI(propLoader.prop.getProperty("RemoteURI") + remoteRepository);
                cloneCommand.setCredentialsProvider(new UsernamePasswordCredentialsProvider(propLoader.prop.getProperty("BITBUCKET_USERNAME"), propLoader.prop.getProperty("BITBUCKET_PASSWORD")));
                cloneCommand.setDirectory(new File(propLoader.prop.getProperty("Clonedirectory")));
                localRepo = cloneCommand.setURI(propLoader.prop.getProperty("RemoteURI") + remoteRepository).setDirectory(new File(String.valueOf(localclonedir))).setCloneSubmodules(true).call();
                openlocaldirectory = Git.init().setDirectory(localclonedir).call();
                git = new Git(openlocaldirectory.getRepository());
                FileRepositoryBuilder FL = new FileRepositoryBuilder();
                Workingdirectory = FL.setGitDir(new File(String.valueOf(localclonedir))).readEnvironment().setWorkTree(new File(localclonedir + "\\" + propLoader.prop.getProperty("worktree"))).findGitDir().build();

            } else {
                LOG.info("\n Repository already cloned");
                Git openlocaldirectory = Git.init().setDirectory(localclonedir).call();
                git = new Git(openlocaldirectory.getRepository());
                FileRepositoryBuilder FL = new FileRepositoryBuilder();
                Workingdirectory = FL.setGitDir(new File(String.valueOf(localclonedir))).readEnvironment().setWorkTree(new File(localclonedir + "\\" + propLoader.prop.getProperty("worktree"))).findGitDir().build();

            }
        } finally {
            if (git != null) {
                localRepo.close();
                cloneCommand.getRepository().close();

            }

        }

    }

    /**
     * delete the local cloned directory
     *
     * @throws IOException
     */
    public void tearDown() throws IOException {
        try {
            FileUtils.forceDelete(new File(localclonedir.getParent()));
            LOG.info("Repository deleted");
        } catch (Exception e) {
            Assert.fail("repository delete failed");
        }

    }


    /**
     * This method create a new directory and file inside
     *
     * @param directoryName
     * @param fileName
     * @return
     * @throws IOException
     * @throws GitAPIException
     */
    public File createDirectoryAndFile(String directoryName, String fileName) throws IOException, GitAPIException {
        File newDirectory = null;
        try {
            newDirectory = FileUtil.createRepoDirectory(Workingdirectory.getWorkTree() + "\\" + directoryName);
            FileUtil.createFile(newDirectory, fileName);
            AddCommand add = git.add();
            add.addFilepattern(propLoader.prop.getProperty("worktree")).call();
            LOG.info("Directory and File Created");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return newDirectory;
    }

    /**
     * Create New file in Working Tree or Working directory
     *
     * @param filename File to be created
     * @throws IOException     IOException
     * @throws GitAPIException GitAPIException
     */

    public void createfile(String filename) throws IOException, GitAPIException {
        try {
            FileUtil.createFile(Workingdirectory.getWorkTree(), filename);
            AddCommand add = git.add();
            add.addFilepattern(propLoader.prop.getProperty("worktree")).call();
            LOG.info("File Created");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Rename old directory
     *
     * @param oldDirectoryName
     * @param newDirectoryName
     * @return
     * @throws IOException
     * @throws GitAPIException
     */

    public boolean renameDirectory(String oldDirectoryName, String newDirectoryName) throws
            IOException, GitAPIException {
        boolean status = false;
        try {
            openlocaldirectory = Git.init().setDirectory(localclonedir).call();
            git = new Git(openlocaldirectory.getRepository());
            FileRepositoryBuilder FL = new FileRepositoryBuilder();
            Workingdirectory = FL.setGitDir(new File(String.valueOf(localclonedir))).readEnvironment().setWorkTree(new File(localclonedir + "\\" + propLoader.prop.getProperty("worktree"))).findGitDir().build();
            File dir = new File(Workingdirectory.getWorkTree() + "\\" + oldDirectoryName);
            if (!dir.isDirectory()) {
                LOG.info("No directory at given path");
                return status;
            } else if (dir.isDirectory()) {
                File newDir = new File(dir.getParent() + "\\" + newDirectoryName);
                dir.renameTo(newDir);
                AddCommand add = git.add();
                add.addFilepattern(propLoader.prop.getProperty("worktree")).call();
                git.add().setUpdate(true).addFilepattern(propLoader.prop.getProperty("worktree")).call();
                LOG.info("Directory renamed");
                status = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    /**
     * Rename file
     *
     * @throws IOException
     * @throws GitAPIException
     */

    public boolean renameFile(String newFilename) throws IOException, GitAPIException {
        boolean status = false;
        try {
            openlocaldirectory = Git.init().setDirectory(localclonedir).call();
            git = new Git(openlocaldirectory.getRepository());
            FileRepositoryBuilder FL = new FileRepositoryBuilder();
            Workingdirectory = FL.setGitDir(new File(String.valueOf(localclonedir))).readEnvironment().setWorkTree(new File(localclonedir + "\\" + propLoader.prop.getProperty("worktree"))).findGitDir().build();
            File oldFileName = new File(String.valueOf(FileUtil.getDynamicFileName()));
            File newFileName = new File(Workingdirectory.getWorkTree(), newFilename);
            if (oldFileName.renameTo(newFileName)) {
                status = true;
                AddCommand add = git.add();
                add.addFilepattern(propLoader.prop.getProperty("worktree")).call();
                git.add().setUpdate(true).addFilepattern(propLoader.prop.getProperty("worktree")).call();
                LOG.info("File in repository renamed");
            } else {
                LOG.info("File in repository renamed");
                return status;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    /**
     * Directory which needs to be deleted
     *
     * @param directoryName
     * @return
     * @throws IOException
     * @throws GitAPIException
     */
    public boolean deleteDirectory(String directoryName) throws IOException, GitAPIException {
        boolean status = false;
        openlocaldirectory = Git.init().setDirectory(localclonedir).call();
        git = new Git(openlocaldirectory.getRepository());
        FileRepositoryBuilder FL = new FileRepositoryBuilder();
        Workingdirectory = FL.setGitDir(new File(String.valueOf(localclonedir))).readEnvironment().setWorkTree(new File(localclonedir + "\\" + propLoader.prop.getProperty("worktree"))).findGitDir().build();
        File dir = new File(Workingdirectory.getWorkTree() + "\\" + directoryName);

        if (dir.isDirectory()) {
            if (dir.listFiles().length != 0) {
                String files[] = dir.list();
                for (String temp : files) {
                    File fileDelete = new File(dir, temp);
                    delete(fileDelete);
                    git.rm().addFilepattern("fileDelete").call();
                }
                dir.delete();
                git.rm().addFilepattern(propLoader.prop.getProperty("worktree") + "/" + directoryName).call();
                return true;
            } else
                dir.delete();
            git.rm().addFilepattern(propLoader.prop.getProperty("worktree") + "\\" + directoryName).call();
            return true;

        }
        return status;
    }


    /**
     * @return delete the file
     * @throws IOException
     * @throws GitAPIException
     */

    public boolean deleteFile() throws IOException, GitAPIException {
        boolean status = false;
        openlocaldirectory = Git.init().setDirectory(localclonedir).call();
        git = new Git(openlocaldirectory.getRepository());
        FileRepositoryBuilder FL = new FileRepositoryBuilder();
        Workingdirectory = FL.setGitDir(new File(String.valueOf(localclonedir))).readEnvironment().setWorkTree(new File(localclonedir + "\\" + propLoader.prop.getProperty("worktree"))).findGitDir().build();
        File fileName = new File(String.valueOf(FileUtil.getDynamicFileName()));
        File file = new File(String.valueOf(fileName));
        if (!file.exists()) {
            return false;
        } else {
            file.delete();
            status = true;
            git.add().setUpdate(true).addFilepattern(propLoader.prop.getProperty("worktree")).call();
        }
        return status;
    }

    /**
     * Commit the changes
     *
     * @param message commit message
     */

    public void commit(String message) {
        try {
            RevCommit commit = git.commit().setMessage(message).call();
            LOG.info("Changes are Committed Successfully");
        } catch (Exception C) {
            LOG.info("Changes are not Committed");
        }

    }

    /**
     * Push the changes to remote repository
     *
     * @param remoteRepository Remote Repository URI
     */
    public void push(String remoteRepository) {
        try {
            UsernamePasswordCredentialsProvider credentialsProvider = new UsernamePasswordCredentialsProvider(propLoader.prop.getProperty("BITBUCKET_USERNAME"), propLoader.prop.getProperty("BITBUCKET_PASSWORD"));
            git.push().setRemote(propLoader.prop.getProperty("RemoteURI") + remoteRepository).setCredentialsProvider(credentialsProvider).call();
            LOG.info("Changes have been pushed to remote repository");
        } catch (Exception E) {
            LOG.info("Changes are not pushed to remote repository");
        }


    }

    /**
     * This method to generate number of files
     *
     * @param noOfFiles
     * @param path
     * @throws IOException
     * @throws GitAPIException
     */
    public void createMultipleFiles(String noOfFiles, String path) throws IOException, GitAPIException {
        try {
            FileUtil.createMultipleFiles(Workingdirectory.getDirectory() + "\\" + propLoader.prop.getProperty("worktree").replace("/", "\\") + "\\" + path, noOfFiles);
            LOG.info("Multiple files created");
            AddCommand add = git.add();
            add.addFilepattern(propLoader.prop.getProperty("worktree") + "/" + path).call();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * This method is to modify multiple file names
     *
     * @param path
     * @throws GitAPIException
     */
    public void modifyFileNames(String path) throws GitAPIException {
        try {
            FileUtil.renameFile(Workingdirectory.getWorkTree() + "\\" + path);
            LOG.info("File name modified");
            AddCommand add = git.add();
            add.addFilepattern(propLoader.prop.getProperty("worktree") + "/" + path).call();
            git.add().setUpdate(true).addFilepattern(propLoader.prop.getProperty("worktree") + "/" + path).call();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * This method is to delete the renamed files
     *
     * @param path
     * @throws GitAPIException
     */
    public void deleteModifiedFiles(String path) throws GitAPIException {
        try {
            FileUtil.deleteMultipleFiles(Workingdirectory.getWorkTree() + "\\" + path);
            LOG.info("Modified files deleted");
            git.add().setUpdate(true).addFilepattern(propLoader.prop.getProperty("worktree") + "/" + path).call();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * This method is to modify the file with random content
     *
     * @param fileName
     * @param filePath
     * @throws GitAPIException
     */
    public void modifyFileContent(String fileName, String filePath) throws GitAPIException {
        try {
            FileUtil.modifyFileContent(Workingdirectory.getWorkTree() + "\\" + filePath + "\\" + fileName);
            git.add().setUpdate(true).addFilepattern(propLoader.prop.getProperty("worktree") + "/" + filePath).call();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
