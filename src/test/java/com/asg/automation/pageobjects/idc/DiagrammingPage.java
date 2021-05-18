package com.asg.automation.pageobjects.idc;

import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.wrapper.UIWrapper;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;

import java.util.List;

/**
 * Created by Divya.Bharathi on 5/30/2018.
 */
public class DiagrammingPage extends UIWrapper {

    private WebDriver driver;

    @FindBy(css = "div[class= 'asg-diagram-container']")
    public WebElement lineageDiagramContainer;

    @FindBy(css = "div[class='asg-diagram-container']")
    public WebElement diagrammingMenu;

    @FindBy(xpath = "//div[@class[contains(.,'asg-diagram-icon-fullsize cursor-pointer')]]")
    public WebElement fullViewIcon;

    @FindBy(xpath = "//div[@class[contains(.,'asg-diagram-icon-normsize cursor-pointer')]]")
    public WebElement normalSizeIcon;

    @FindBy(css = "div[class='asg-diagram-container asg-diagram-widget-full-size']")
    public WebElement diagrammingFullView;

    @FindBy(xpath = "(//div[@class='asg-diagram-toolbar-slider-bar'])[2]")
    public WebElement scrolltoHighdetails;

    @FindBy(xpath = "(//div[@class='asg-diagram-toolbar-slider-bar'])[1]")
    public WebElement scrolltoLowdetails;


    @FindBy(xpath = "(//div[@class='asg-diagram-toolbar-slider-bar'])[1]")
    public WebElement detailsScroll;

    @FindBy(css = "div[class='asg-diagram-icon-down']")
    public WebElement lineageDropdownButton;

    @FindBy(css = "div[class='asg-diagram-icon-query-BOTH']")
    public WebElement endToEndLineageIcon;

    @FindBy(css = "div[class='asg-diagram-icon asg-diagram-icon-minus cursor-pointer']")
    public WebElement zoomOutIcon;

    @FindBy(css = "div[class='asg-diagram-icon asg-diagram-icon-plus cursor-pointer']")
    public WebElement zoomInIcon;

    @FindBy(xpath = "//div[@class='asg-diagram-container']//following::*[name()=\"g\"]")
    public WebElement diagramImage;

    @FindBy(css = "span[class='asg-dynamic-form-select-drop-down-icon float-right']>i")
    public WebElement themeDropdownButton;

    @FindBy(xpath = "//ul[@class[contains(.,'dropdown-menu show')]]/li/a")
    public List<WebElement> themeDropdownList;

    @FindBy(className = "nodes")
    public WebElement nodes;

    @FindBy(xpath = "//ul[@class[contains(.,'nav nav-tabs item-view-categories')]]/li/a")
    public List<WebElement> subjectAreatabList;

    @FindBy(css = "div[class='asg-diagram-menu-row']>div[class='asg-diagram-icon-open-item']")
    public WebElement openItem;

    @FindBy(css = "div[class='asg-diagram-menu-row']>div[class='asg-diagram-icon-expand']")
    public WebElement drillDownIconExpand;

    @FindBy(css = "div[class='asg-diagram-menu-row']>div[class='asg-diagram-icon-collapse']")
    public WebElement drillDownIconCollapse;

    @FindBy(css = "div[class='asg-diagram-menu-row']>div[class='asg-diagram-icon-drillup']")
    public WebElement drillUpIcon;

    @FindBy(xpath = "//div[@class[contains(.,'asg-diagram-toolbar-button')]]/div[@class='asg-diagram-icon-expand-all']")
    public WebElement expandAll;

    @FindBy(css = "div[class='asg-diagram-icon-collapse-all']")
    public WebElement collapseAll;

    @FindBy(xpath = "//*[@class='nodes']//*[@class='asg-diagram-type-Column nodebox']//*[@class='nodetext']")
    public List<WebElement> columnList;


    @FindBy(xpath = "//*[@class='nodeparent']//following::*[@class='nodetext']")
    public List<WebElement> allContent;

    @FindBy(xpath = "//*[@class='nodes']//*[@class='asg-diagram-type-Table nodebox']//*[@class='nodetext']")
    public List<WebElement> tableList;

    @FindBy(xpath = "//*[@class='nodetspan'][contains(., 'Cluster')]")
    public List<WebElement> clusterList;

    @FindBy(xpath = "//*[@class='edge']")
    public List<WebElement> operation;

    @FindBy(css = "div[class='asg-diagram-icon asg-diagram-icon-100 cursor-pointer']")
    public WebElement oneIsToOne;

    @FindBy(css = "div[class='asg-diagram-icon-fullsize cursor-pointer']")
    public WebElement diagramFullView;

    @FindBy(css = "div[class='asg-diagram-icon-normsize cursor-pointer']")
    public WebElement diagramNormalView;

    @FindBy(xpath = "//div[@class[contains(.,'asg-diagram-menu-popup')]]")
    public List<WebElement> actionMenuPopUp;

    @FindBy(className = "asg-diagram")
    public WebElement diagram;

    @FindBy(xpath = "//div[@class[contains(.,'asg-diagram-toolbar d-flex')]]/div/div")
    public WebElement toolBarCloseArrow;

    @FindBy(xpath = "//div[@class[contains(.,'asg-diagram-toolbar d-flex')]]//div[@class='asg-diagram-toolbar-label'][contains(.,'VIEW')]")
    public WebElement viewLabel;

    @FindBy(xpath = "//div[@class[contains(.,'asg-diagram-toolbar-element query-element')]]/div[@class='asg-diagram-icon-query-queryDiagramOut']")
    public WebElement viewMenu;

    @FindBy(xpath = "//div[@class[contains(.,'asg-diagram-menu-popup')]]/div[@class[contains(.,'asg-diagram-menu-row')]]")
    public List<WebElement> viewSubMenuList;

    @FindBy(xpath = "//div[@class[contains(.,'asg-diagram-toolbar-label')]][contains(.,'DETAILS')]")
    public WebElement detailsLabel;

    @FindBy(xpath = "//div[@class[contains(.,'asg-diagram-toolbar-element asg-diagram-toolbar-noborder')]]")
    public WebElement zoomSlider;

    @FindBy(xpath = "//div[@class='asg-diagram-icon-wheel']")
    public WebElement settingMenu;

    @FindBy(xpath = "//div[@class='asg-diagram-menu-row']/table/tbody/tr/td")
    public List<WebElement> settingSubMenuList;

    @FindBy(xpath = "//div[@class[contains(.,'asg-diagram-toolbar-button')]]//div[contains(.,'Select')]")
    public WebElement lineageSelectOptions;

    @FindBy(xpath = "//div[@class[contains(.,'asg-diagram-menu-popup')]]/div")
    public List<WebElement> lineageSelectSubMenuList;

    @FindBy(xpath = "//div[@class[contains(.,'asg-diagram-toolbar-element')]]//input")
    public WebElement searchField;

    @FindBy(css = "div[class='asg-diagram-zoombar-down']>div")
    public List<WebElement> zoomBarList;

    @FindBy(xpath = "//div[@class[contains(.,'asg-diagram-toolbar-noborder')]][contains(.,'More Actions')]")
    public WebElement moreActionsMenu;

    @FindBy(xpath = "//div[@class[contains(.,'asg-diagram-menu-popup')]]/div")
    public List<WebElement> moreActionsSubMenuList;

    @FindBy(css = "g[class='edgeicon']")
    public WebElement lineageEdgeIcon;

    @FindBy(css = "div[class='asg-diagram-hop-info']")
    public WebElement lineageHopInfoIcon;

    @FindBy(xpath = "//*[@class='edgeicon']")
    public WebElement edgeIconFirefox;

    @FindBy(css = "div[class='asg-diagram-toolbar-element']>div[class='asg-diagram-toolbar-noborder']")
    public WebElement schemaViewSelectiondropdown;

    @FindBy(xpath = "(//div[@class='asg-diagram-toolbar-slider-bar'])[1]")
    public WebElement clickdetailradiobutton;

    @FindBy(xpath = "(//div[@class='asg-diagram-toolbar-slider-bar'])[2]")
    public WebElement dropradiobutton;

    @FindBy(css = "ul[class='nav nav-tabs dashboard-tabs-panel']>li>a")
    public List<WebElement> schemaViewDropDownList;

    @FindBy(css = "ul[class='nav nav-tabs dashboard-tabs-panel']>li>a")
    public List<WebElement> dashBoard;

    @FindBy(css = "div.d-flex.align-items-center.asg-diagram-toolbar-views > div > div > div > div > div.far.fa-angle-down")
    public WebElement relationshipsDropDown;

    @FindBy(xpath = "//div[@class='asg-diagram-icon-select']//following::div[@class='asg-diagram-icon-down'][1]")
    public WebElement selectDropDown;

    @FindBy(xpath = "//span[contains(text(),'More Actions')]//following::div[@class='asg-diagram-icon-down'][1]")
    public WebElement moreActionsDropDown;

    @FindBy(css = "input[class='asg-diagram-toolbar-noborder asg-diagram-toolbar-searchfield']")
    public WebElement searchBox;

    @FindBy(css = "input[class='asg-diagram-toolbar-noborder asg-diagram-toolbar-searchfield-edge']")
    public WebElement searchBox_Edge;

    @FindBy(css = "div[class='asg-diagram-icon-search']")
    public WebElement searchIcon;

    @FindBy(xpath = "//*[@class='edgeicon'][1]")
    public WebElement diamondicon;

    @FindBy(css = "div.asg-diagram-icon-edgeinfo")
    public WebElement edgeInfoIcon;

    @FindBy(css = "div[class='asg-diagram-icon-expand-all']")
    public WebElement expandAllButton;

    @FindBy(css = "div[class='asg-diagram-icon-collapse-all']")
    public WebElement collapseAllButton;

    @FindBy(xpath = "//*[@class='nodetext'][contains(.,'Collapsed Item')]//following::*[@class='drillicon']")
    public WebElement collapseExpandButton;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item full-size-item')]]//i[@class='fa fa-times']")
    public WebElement closeButton;

    @FindBy(css = "div[class='asg-diagram-icon-down']")
    public WebElement viewSelectionDropDown;

    @FindBy(css = "div[class='asg-diagram-menu-row']")
    public List<WebElement> viewSelectionDropdownList;

    @FindBy(css = "em[class='far fa-tag asg-diagram-icon-style']")
    public WebElement filterTagsIcon;

    @FindBy(xpath = "//*[@class='nodetspan'][contains(.,'[Table]')]/preceding::*[@class='edgeicon']")
    public WebElement copyLineageEdgeIcon;

    @FindBy(xpath = "//*[@class='nodetspan'][contains(.,'[Table]')]/preceding::*[@class='edgeicon'][1]")
    public WebElement stichLineageEdgeIcon;

    @FindBy(xpath = "//*[@class='nodetspan'][contains(.,'[File]')]/preceding::*[@class='edgeicon'][1]")
    public WebElement stichFileLineageEdgeIcon;

    @FindBy(xpath = "//span[contains(.,'Mode')]//following-sibling::strong")
    public WebElement lineageHopMode;


    public DiagrammingPage(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Intialized Diagramming page");
    }

    public WebElement getDiagrammingMenu() {
        return diagrammingMenu;
    }

    public WebElement getFullViewIcon() {
        return fullViewIcon;
    }

    public WebElement getNormalSizeIcon() {
        return normalSizeIcon;
    }

    public WebElement getDiagrammingFullView() {
        return diagrammingFullView;
    }

    public WebElement getScrolltoHighdetails() {
        return scrolltoHighdetails;
    }

    public WebElement getDetailsScroll() {
        return detailsScroll;
    }

    public WebElement getScrolltoLowdetails() {
        return scrolltoLowdetails;
    }


    public WebElement getAnyDisplayedNode(String nodeName) {

        return driver.findElement(By.xpath("//*[@class[contains(.,'asg-diagram-type-" + nodeName + " nodebox')]][1]/*[name()='rect'][1]"));
    }

    public WebElement getCloseButton() {
        return closeButton;
    }

    public WebElement getViewSelectionDropDown() {
        synchronizationVisibilityofElement(driver, viewSelectionDropDown);
        return viewSelectionDropDown;
    }

    public void clickAnddragdetailsbutton() {
        dragAndDrop(driver, clickdetailradiobutton, dropradiobutton);
    }

    public List<WebElement> getViewSelectionDropdownList() {
        synchronizationVisibilityofElementsList(driver, viewSelectionDropdownList);
        return viewSelectionDropdownList;
    }

    public List<WebElement> getalloptions() {
        synchronizationVisibilityofElementsList(driver, allContent);
        return allContent;
    }

    public WebElement getRelationshipsDropDown() {
        return relationshipsDropDown;
    }


    public WebElement getSelectDropDown() {
        return selectDropDown;
    }

    public WebElement getMoreActionsDropDown() {
        return moreActionsDropDown;
    }

    public WebElement getZoomOutIcon() {
        return zoomOutIcon;
    }


    public WebElement getLineageDiagramContainer() {
        return lineageDiagramContainer;
    }

    public List<WebElement> getSubjectAreatabList() {
        synchronizationVisibilityofElementsList(driver, subjectAreatabList);
        return subjectAreatabList;
    }

    public WebElement getLineageItemTypes(String itemName, String itemType) {
        return driver.findElement(By.xpath("//*[@class='nodetext'][contains(.,'" + itemName + "')]//*[@class='nodetspan'][contains(.,'[" + itemType + "]')]"));

    }

    public WebElement getLineageTextofAllItems(String itemName, String itemType) {
        return driver.findElement(By.xpath("//*[@class='nodetext'][contains(.,'" + itemName + "')]"));

    }

    public WebElement getItemDrillIcon(String nodeName, String nodeType) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-type-" + nodeType + " nodebox']//*[@class='nodetext'][contains(text(),'" + nodeName + "')]//following::*[@class='drillicon'][1]"));
    }

    public WebElement getItemNameDrillIconEdge(String nodeName, String nodeType) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-type-" + nodeType + " nodebox'][1]//following::*[@class='nodetext'][contains(text(),'" + nodeName + "')]//following::*[@class='drillicon'][1]"));

    }

    public WebElement getOpenItem() {
//        synchronizationVisibilityofElement(driver, openItem);
        return openItem;
    }

    public List<WebElement> getOperations() {
//        synchronizationVisibilityofElement(driver, openItem);
        return operation;
    }

    public WebElement getItemDrillDownExpandIcon() {
        synchronizationVisibilityofElement(driver, drillDownIconExpand);
        return drillDownIconExpand;
    }

    public WebElement getItemDrillDownCollapseIcon() {
        synchronizationVisibilityofElement(driver, drillDownIconCollapse);
        return drillDownIconCollapse;
    }

    public WebElement getDrillUpIcon() {
        synchronizationVisibilityofElement(driver, drillUpIcon);
        return drillUpIcon;
    }

    public WebElement getItemName(String nodeType, String nodeName) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-type-" + nodeType + " nodebox']//*[@class='nodetext'][contains(.,'" + nodeName + "')]"));
    }

    public List<WebElement> getParentItemName(String nodeType, String nodeName) {
        return driver.findElements(By.xpath("//*[@class='nodeparent']//*[@class='nodetext'][contains(.,'" + nodeName + " [" + nodeType + "]')]"));
    }

    public WebElement getParentItemIcon(String nodeType, String nodeName) {
        return driver.findElement(By.xpath("//*[@class='nodeparent']//*[@class='nodetext'][contains(.,'" + nodeName + " [" + nodeType + "]')]//following::*[@class='itemicon'][1]"));
    }

    public WebElement getClusterName(String nodeType, String nodeName) {
        return driver.findElement(By.xpath("//*[@class='nodeparent'][1][contains(.,'" + nodeName + " [" + nodeType + "]')]"));
    }

    public WebElement getParentItemNameEdge(String nodeType, String nodeName) {
        return driver.findElement(By.xpath("//*[@class='nodeparent'][1]//following::*[@class='nodetext'][contains(.,'" + nodeName + " [" + nodeType + "]')]"));
    }

    public WebElement getServiceName(String nodeType, String nodeName) {
        return driver.findElement(By.xpath("//*[@class='nodeparent'][2][contains(.,'" + nodeName + " [" + nodeType + "]')]"));
    }

    public WebElement getFileName(String nodeType, String nodeName) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-type-" + nodeType + " nodebox'][contains(.,'" + nodeName + "')]"));
    }

    public WebElement getDBItemNameEdge(String nodeType, String nodeName) {
        return driver.findElement(By.xpath("//*[@class='nodeparent'][2]//following::*[@class='nodetext'][contains(.,'" + nodeName + " [" + nodeType + "]')]"));
    }

    public WebElement getZoomInIcon() {
        return zoomInIcon;
    }

    public List<WebElement> getDropDownList(String option) {
        return driver.findElements(By.xpath("//div[@class[contains(.,'asg-diagram-menu-popup')]]/div[@class[contains(.,'asg-diagram-menu-row')]][contains(.,'" + option + "')]"));
    }

    public void clickLineageDropdownButton() {
        clickOn(lineageDropdownButton);
    }

    public WebElement getEndToEndLineageIcon() {
        return endToEndLineageIcon;
    }

    public WebElement getLineageDropdownButton() {
        return lineageDropdownButton;
    }

    public WebElement getDiagramImage() {
        return diagramImage;
    }

    public void clickZoomInIcon() {
        clickOn(zoomInIcon);
    }

    public void clickThemeDropdownButton() {
        clickOn(themeDropdownButton);
    }

    public List<WebElement> getThemeDropdownList() {
        return themeDropdownList;
    }

    public WebElement getToolBarSubMenu(String toolBarSubMenu) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-diagram-menu-popup')]]//div[@class[contains(.,'asg-diagram-menu-row')]][contains(.,'" + toolBarSubMenu + "')]"));
    }

    public WebElement getItemEdge(String nodeType, String nodeName) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-container']//following::*[@class='asg-diagram-type-" + nodeType + " nodebox']/*[@class='nodetext'][contains(text(),'" + nodeName + "')]/.."));
    }


    public WebElement getTableItemWidth(String itemName) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-type-Table nodebox'][1]//*[@class='noderect']//following::*[@class='nodetext'][contains(.,'" + itemName + "')]//preceding::*[@class='noderect'][1]"));
    }

    public WebElement getTableItemWidthEdge(String nodeType, String nodeName) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-container']//following::*[@class='asg-diagram-type-" + nodeType + " nodebox']/*[@class='nodetext'][contains(text(),'" + nodeName + "')]//preceding::*[@class='noderect'][1]"));
    }

    public WebElement getExpandAll() {
        synchronizationVisibilityofElement(driver, expandAll);
        return expandAll;
    }

    public WebElement getCollapseAll() {
        synchronizationVisibilityofElement(driver, collapseAll);
        return collapseAll;
    }


    public List<WebElement> getColumnList() {
        return columnList;
    }

    public WebElement getNode(String nodeType, String nodeName) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-type-" + nodeType + " nodebox']/*[name()='text'][contains(text(),'" + nodeName + "')]/.."));
    }

    public WebElement getItemEdgeFullSize(String nodeType, String nodeName) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-container asg-diagram-widget-full-size']//following::*[@class='asg-diagram-type-" + nodeType + " nodebox']/*[@class='nodetext'][contains(text(),'" + nodeName + "')]/.."));
    }

    public WebElement getHamburgerIconEdgeFullSize(String nodeType, String nodeName) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-container asg-diagram-widget-full-size']//following::*[@class='asg-diagram-type-" + nodeType + " nodebox']/*[@class='nodetext'][contains(text(),'" + nodeName + "')]//following::*[@class='itemicon']//*[@id='Layer_2'][1]"));
    }

    public WebElement getHamburgericon(String nodeType, String nodeName) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-type-" + nodeType + " nodebox']/*[name()='text'][contains(.,'" + nodeName + "')]//following::*[@class='itemicon']//*[@id='Layer_2'][1]"));
    }

    public List<WebElement> getHamburgerMenuList() {
        return driver.findElements(By.xpath("//div[@class[contains(.,'asg-diagram-menu-popup')]]/div[@class[contains(.,'asg-diagram-menu-row')]]"));
    }

    public WebElement getDiagrammingSearchBox() {
        return searchBox;
    }

    public WebElement getDiagrammingSearchBox_Edge() {
        return searchBox_Edge;
    }

    public WebElement getDiagrammingSearchIcon() {
        return searchIcon;
    }

    public WebElement getDiamondicon() {
        return diamondicon;
    }

    public WebElement getEdgeInfoIcon() {
        return edgeInfoIcon;
    }

    public WebElement getExpandAllutton() {
        return expandAllButton;
    }

    public WebElement getCollapseAllButton() {
        return collapseAllButton;
    }

    public WebElement getCollapseExpandButton() {
        return collapseExpandButton;
    }

    public WebElement getExpandButton(String nodeName) {
        return driver.findElement(By.xpath("//*[@class='nodetext'][contains(.,'" + nodeName + "')]//following::*[@class='drillicon'][1]"));
    }

    public WebElement getExpandButtonEdge(String nodeName) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-container asg-diagram-widget-full-size']//following::*[@class='nodetext'][contains(.,'" + nodeName + "')]//following::*[@class='drillicon'][1]"));
    }

    public List<WebElement> getTableList() {
        return tableList;
    }

    public List<WebElement> getClusterList() {
        return clusterList;
    }

    public WebElement getClusterNode(String itemName) {
        return driver.findElement(By.xpath("//div[@class='asg-diagram-container']//*[contains(.,'" + itemName + "')]"));
    }

    public WebElement getClusterDrillIcon(String itemName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-diagram-container')]]//*[contains(.,'" + itemName + "')]/*[@class='drillicon']"));
    }

    public WebElement getNodes() {
        synchronizationVisibilityofElement(driver, nodes);
        return nodes;
    }

    public WebElement getOneIsToOne() {
        synchronizationVisibilityofElement(driver, oneIsToOne);
        return oneIsToOne;
    }

    public WebElement getDiagramFullView() {
        return diagramFullView;
    }

    public List<WebElement> getActionMenuPopUp() {
        synchronizationVisibilityofElementsList(driver, actionMenuPopUp);
        return actionMenuPopUp;
    }

    public WebElement getDiagramNormalView() {
        synchronizationVisibilityofElement(driver, diagramNormalView);
        return diagramNormalView;
    }

    public WebElement getItemIconEdge(String nodeName, String nodeType) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-type-" + nodeType + " nodebox'][1]//following::*[@class='nodetext'][contains(text(),'" + nodeName + "')]//following::*[@class='itemicon'][1]"));

    }

    public WebElement getParentItemIconEdge(String nodeType, String nodeName) {
        return driver.findElement(By.xpath("//*[@class='nodeparent'][1]//following::*[@class='nodetext'][contains(.,'" + nodeName + " [" + nodeType + "]')]//following::*[@class='itemicon'][1]"));
    }

    public List<WebElement> getLineageDropDownList() {
        return driver.findElements(By.xpath("//div[@class[contains(.,'asg-diagram-menu-row')]]"));
    }

    public WebElement getItemInfoIcon(String nodeType, String nodeName) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-type-" + nodeType + " nodebox']/*[@class='nodetext'][contains(.,'" + nodeName + "')]//following::*[@class='infoicon'][1]"));
    }

    public WebElement getItemInfoIconEdge(String nodeType, String nodeName) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-container asg-diagram-widget-full-size']//following::*[@class='asg-diagram-type-" + nodeType + " nodebox']/*[name()='text'][contains(.,'" + nodeName + "')]//following::*[@class='infoicon']"));

    }

    public WebElement getItemEdge(String itemName) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-container asg-diagram-widget-full-size']//following::*[@class='nodetext'][contains(text(),'" + itemName + "')]/.."));

    }

    public WebElement getToolBar(String toolBarName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-diagram-toolbar-button')]]//div[contains(.,'" + toolBarName + "')]"));
    }

    public WebElement getReloadButton() {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-diagram-toolbar-button')]]//div[@class[contains(.,'reload')]]"));
    }

    public WebElement getDiagram() {
        synchronizationVisibilityofElement(driver, diagram);
        return diagram;
    }

    public WebElement getToolBarCloseArrow() {
        synchronizationVisibilityofElement(driver, toolBarCloseArrow);
        return toolBarCloseArrow;
    }

    public WebElement getViewLabel() {
        synchronizationVisibilityofElement(driver, viewLabel);
        return viewLabel;
    }

    public WebElement getViewMenu() {
        synchronizationVisibilityofElement(driver, viewMenu);
        return viewMenu;
    }

    public List<WebElement> getViewSubMenuList() {
        synchronizationVisibilityofElementsList(driver, viewSubMenuList);
        return viewSubMenuList;
    }

    public WebElement getDetailsLabel() {
        synchronizationVisibilityofElement(driver, detailsLabel);
        return detailsLabel;
    }

    public WebElement getSettingMenu() {
        synchronizationVisibilityofElement(driver, settingMenu);
        return settingMenu;
    }

    public List<WebElement> getSettingMenuList() {
        synchronizationVisibilityofElementsList(driver, settingSubMenuList);
        return settingSubMenuList;
    }

    public WebElement getZoomSlider() {
        synchronizationVisibilityofElement(driver, zoomSlider);
        return zoomSlider;
    }

    public WebElement getLineageSelectOptions() {
        synchronizationVisibilityofElement(driver, lineageSelectOptions);
        return lineageSelectOptions;
    }

    public List<WebElement> getLineageSelectSubMenuList() {
        synchronizationVisibilityofElementsList(driver, lineageSelectSubMenuList);
        return lineageSelectSubMenuList;
    }

    public WebElement getSearchField() {
        synchronizationVisibilityofElement(driver, searchField);
        return searchField;
    }

    public List<WebElement> getZoomBarList() {
        synchronizationVisibilityofElementsList(driver, zoomBarList);
        return zoomBarList;
    }

    public WebElement getMoreActionsMenu() {
        synchronizationVisibilityofElement(driver, moreActionsMenu);
        return moreActionsMenu;
    }

    public List<WebElement> getMoreActionsSubMenuList() {
        synchronizationVisibilityofElementsList(driver, moreActionsSubMenuList);
        return moreActionsSubMenuList;
    }

    public WebElement getItemEdgeText(String edgeTextName) {
        return driver.findElement(By.xpath("//*[@class='edges']/*[@class='edge']/*[contains(.,'" + edgeTextName + "')]"));
    }

    public WebElement getItemEdgeBrowserText(String edgeTextName) {
        return driver.findElement(By.xpath("//*[contains(.,'" + edgeTextName + "')]"));
    }

    public WebElement getSettingsCheckBox(String checkBoxName) {
        return driver.findElement(By.xpath("//div[@class='asg-diagram-menu-row']//table/tbody/tr/td[contains(.,'" + checkBoxName + "')]//preceding::label[1]"));
    }

    public WebElement getDrillDownIconCollapse(String nodeName, String nodeType) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-type-" + nodeType + " nodebox']//*[@class='nodetext'][contains(text(),'" + nodeName + "')]//following::*[@class='drillicon'][1]"));

    }

    public WebElement getItemInPanelView(String itemName, String itemType) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-panels-active-item')]]//div//b[@title='" + itemName + "']//following::span[contains(.,'[" + itemType + "]')]"));
    }

    public WebElement getItemInFullView(String itemName, String itemType) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-panels-active-item full-size-item')]]//div//p//b[@title='" + itemName + "']//following::span[contains(.,'" + itemType + "')]"));
    }

    public WebElement getLineageEdgeIcon() {
        synchronizationVisibilityofElement(driver, lineageEdgeIcon);
        return lineageEdgeIcon;
    }

    public WebElement getCopyLineageEdgeIcon() {
        synchronizationVisibilityofElement(driver, copyLineageEdgeIcon);
        return copyLineageEdgeIcon;
    }

    public WebElement getStichLineageEdgeIcon() {
        synchronizationVisibilityofElement(driver, stichLineageEdgeIcon);
        return stichLineageEdgeIcon;
    }

    public WebElement getStichFileLineageEdgeIcon() {
        synchronizationVisibilityofElement(driver, stichFileLineageEdgeIcon);
        return stichFileLineageEdgeIcon;
    }

    public WebElement getLineageHopInfoIcon() {
        synchronizationVisibilityofElement(driver, lineageHopInfoIcon);
        return lineageHopInfoIcon;
    }

    public WebElement getLineageHopMode() {
        synchronizationVisibilityofElement(driver, lineageHopMode);
        return lineageHopMode;
    }

    public WebElement getEdgeIconFirefox() {
        return edgeIconFirefox;
    }

    public WebElement getItemIcon(String nodeName, String nodeType) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-type-" + nodeType + " nodebox']//*[@class='nodetext'][contains(.,'" + nodeName + "')]//following::*[@class='itemicon'][1]"));

    }

    public WebElement getExpandScope() {
        return driver.findElement(By.cssSelector("input[class='asg-diagram-toolbar-slider']"));
    }

    public WebElement getExpandScopeSliderLow(String position) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'sliderticks ng-star-inserted')]]/p[" + position + "]"));
    }

    public WebElement getHighDetails() {
        return driver.findElement(By.xpath("//div[@class='asg-diagram-toolbar-slider-label'][contains(.,' Details ')]"));
    }

    public WebElement getHighDetailsSlider(String position) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'sliderticks ng-star-inserted')]]/p[" + position + "]"));
    }

    public WebElement getAbstraction() {
        return driver.findElement(By.xpath("//div[contains(.,'ABSTRACTION')]/following::div[@class='asg-diagram-icon-slider-bar-icon']"));
    }

    public WebElement getExportSVGIcon() {
        return driver.findElement(By.xpath("//em[@class='fal fa-file-download asg-diagram-icon-eport-svg-style']"));
    }

    public WebElement getReloadIcon() {
        return driver.findElement(By.xpath("//em[@class='fas fa-redo-alt asg-diagram-icon-style']"));
    }

    public WebElement getZoominIcon() {
        return driver.findElement(By.xpath("//em[@class='fas fa-plus asg-diagram-icon-style']"));
    }

    public WebElement getZoomoutIcon() {
        return driver.findElement(By.xpath("//em[@class='fas fa-minus asg-diagram-icon-style']"));
    }

    public WebElement getOutside() {
        return driver.findElement(By.xpath("//*[@class='asg-diagram']"));
    }

    public WebElement GetTabName(String Tab) {
        return driver.findElement(By.xpath("//div[@class='asg-item-view-tabs']//li/a[contains(text(), '" + Tab + "')]"));
    }

    public WebElement getFullSizeIcon()
    {
        return driver.findElement(By.xpath("//em[@class='fas fa-expand asg-diagram-icon-style']"));
    }

    public WebElement getCollapseFullViewSizeIcon()
    {
        return driver.findElement(By.xpath("//em[@class='fas fa-compress asg-diagram-icon-style']"));
    }

    public WebElement getInfoPopupCloseIcon()
    {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-info-icon-close far fa-times']"));
    }

    public WebElement getDropdownButtonOfTheField() {
        return driver.findElement(By.xpath("//div[@class='fa-angle-down far']"));
    }

    public WebElement getselectDropdownButtonOfTheField() {
        return driver.findElement(By.xpath("//div[@class[contains(.,'fa-angle-down')]]"));
    }

    public WebElement getAttributeInDropdown(String Options) {
        return driver.findElement(By.xpath("//div[@class='asg-diagram-menu-popup menuView']/div[contains(.,'" + Options + "')]"));
    }

    public WebElement getselectAttributeInDropdown(String Options) {
        return driver.findElement(By.xpath("//div[@class='asg-diagram-menu-popup menuSelect']/div[contains(.,'" + Options + "')]"));
    }

    public WebElement getZoomTextbox() {
        return driver.findElement(By.xpath("//div[@class='asg-diagram-toolbar-zoom-textbox mr-0']"));
    }

    public WebElement getSearchTextbox() {
        return driver.findElement(By.xpath("//input[@class='asg-diagram-toolbar-noborder asg-diagram-toolbar-searchfield']"));
    }
    public WebElement getSelectAll() {
        return driver.findElement(By.xpath("//*[@style='rx: 3; ry: 3; stroke: rgb(26, 52, 64); stroke-width: 2;']"));
    }

    public WebElement getExpandSelected() {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-type-Column nodebox']"));
    }

    public WebElement getGroupSelected(String Groups) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-type-_cluster_ nodebox']//*[contains(., '"+Groups+"')]"));
    }

    public WebElement getZoomMinus() {
        return driver.findElement(By.xpath("//*[contains(@transform,'scale(0.9)')]"));
    }

    public WebElement getZoomPlus() {
        return driver.findElement(By.xpath("//*[contains(@transform,'scale(1.1)')]"));
    }
    public WebElement getParentNode(String type) {
        return driver.findElement(By.xpath("//*[@class='nodeparent']//*[contains(., '"+type+"')]"));
    }

    public WebElement getIteminfoPopup() {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-info-popup ng-star-inserted']"));
    }

    public WebElement getIteminfoPopupdetails(String info) {
        return driver.findElement(By.xpath("//*[@class='asg-diagram-info-key'][contains(., '"+info+"')]"));
    }

    public WebElement getFilterTags(String tagName) {
        return driver.findElement(By.xpath("//td[contains(.,'"+tagName+"')]/preceding-sibling::td/input[1]"));
    }

    public WebElement getFilterTagsIcon(){
        return  filterTagsIcon;
    }

    public void genericClick(String elementName, String... dynamicItem) {

        try {
            switch (elementName) {
                case "DETAILS":
                    dragAndDrop(driver, getHighDetailsSlider("5"), getHighDetailsSlider(dynamicItem[0]));
                    break;
                case "ABSTRACTION":
                    clickOn(driver, getAbstraction());
                    dragAndDrop(driver, getHighDetailsSlider("3"), getHighDetailsSlider(dynamicItem[0]));
                    break;
                case "EXPAND SCOPE":
                    waitForAngularLoad(driver);
                    dragAndDrop(driver, getExpandScopeSliderLow("1"), getExpandScopeSliderLow(dynamicItem[0]));
                    break;
                case "ExportSVGIcon":
                    clickOn(driver, getExportSVGIcon());
                    break;
                case "Reload":
                    clickOn(driver, getReloadIcon());
                    break;
                case "ZOOMIN+":
                    clickOn(driver, getZoominIcon());
                    break;
                case "ZOOMOUT-":
                    clickOn(driver, getZoomoutIcon());
                    break;
                case "Outside":
                    clickOn(driver, getOutside());
                    break;
                case "Lineage":
                case"Relationships":
                case "Stewardship":
                    clickOn(driver, GetTabName(elementName));
                    waitForAngularLoad(driver);
                  break;
                case "FullSize":
                    clickOn(driver,getFullSizeIcon());
                    waitForAngularLoad(driver);
                    break;
                case "Collapse Full Size":
                    clickOn(driver,getCollapseFullViewSizeIcon());
                    waitForAngularLoad(driver);
                    break;
                case"Item info Close":
                    clickOn(driver, getInfoPopupCloseIcon());
                    waitForAngularLoad(driver);
                    break;
                case "Filter tags icon":
                    clickOn(driver,getFilterTagsIcon());
                    waitForAngularLoad(driver);
                    break;
                case "Filter tags":
                    clickOn(driver,getFilterTags(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "SCOPE":
                    waitForAngularLoad(driver);
                    setSliderValue(driver, getExpandScope(), dynamicItem[0]);
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void enterActions(String elementType, String text) {
        switch (elementType) {
            case "100":
                clearTextWithJavaScript(driver, getZoomTextbox());
                enterText(getZoomTextbox(), text);
                break;
            case "customerID":
                clearTextWithJavaScript(driver, getSearchTextbox());
                enterText(getSearchTextbox(), text);
                break;

                }

    }

    public void LineageDiagrammingpage(String option) throws Exception {
        moveToElement(driver, getDropdownButtonOfTheField());
        clickonWebElementwithJavaScript(driver, getDropdownButtonOfTheField());
        waitForAngularLoad(driver);
        sleepForSec(500);
        clickonWebElementwithJavaScript(driver, getAttributeInDropdown(option));
        waitUntilJSReady(driver);
        waitForAngularLoad(driver);

    }

    public void SelectMenuLineageDiagrammingpage(String option) throws Exception {
        moveToElement(driver, getselectDropdownButtonOfTheField());
        clickonWebElementwithJavaScript(driver, getselectDropdownButtonOfTheField());
        waitForAngularLoad(driver);
        sleepForSec(500);
        clickonWebElementwithJavaScript(driver, getselectAttributeInDropdown(option));
        waitUntilJSReady(driver);
        waitForAngularLoad(driver);

    }

    public void genericVerifyElementPresent(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "Select All":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getSelectAll()));
                    break;
                case "Expand":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getExpandSelected()));
                    break;
                case "Collapsed Item Set 2":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getGroupSelected(elementName)));
                    break;
                case "90":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getZoomMinus()));
                    break;
                case "110":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getZoomPlus()));
                    break;
                case "[Cluster]":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getParentNode(elementName)));
                    break;
                case "Item info popup":
                    takeScreenShot(elementName + "is captured",driver);
                    Assert.assertTrue(isElementPresent(getIteminfoPopup()));
                    break;
                case "Name":
                case "Definition":
                case "Tags":
                case "Catalog":
                case"Rating":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementPresent(getIteminfoPopupdetails(elementName)));
                    break;
                case "Filter tags Icon":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementPresent(getFilterTagsIcon()));
                    break;
                case "Lineage Icon":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementPresent(getLineageEdgeIcon()));
                    break;
            }

        }
        catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyElementNotPresent(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "Select All":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isNotElementPresent(getSelectAll()));
                    break;
                case "Expand":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertFalse(isNotElementPresent(getExpandSelected()));
                    break;

            }

        }
        catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void verifyLineageDiagrammingPopUpContent(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "Title":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(getElementText(getLineageHopInfoIcon()).equals(dynamicItem[0]));
                    break;
                case "Mode":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(getElementText(getLineageHopMode()).equals(dynamicItem[0]));
                    break;
             }

        }
        catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }
}