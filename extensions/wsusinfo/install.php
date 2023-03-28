<?php
/**
 * The following functions are used by the extension engine to generate a new table
 * for the plugin / destroy it on removal.
 */


/**
 * This function is called on installation and is used to 
 * create database schema for the plugin
 */
function extension_install_wsusinfo()
{
    $commonObject = new ExtensionCommon;

    $commonObject -> sqlQuery(
        "CREATE TABLE wsusinfo(
        ID INTEGER NOT NULL AUTO_INCREMENT, 
        HARDWARE_ID INTEGER NOT NULL,
        PROPERTY VARCHAR(50) DEFAULT NULL,
        VALUE VARCHAR(250) DEFAULT NULL,
        PRIMARY KEY (ID,HARDWARE_ID)) ENGINE=INNODB;"
    );
}

/**
 * This function is called on removal and is used to 
 * destroy database schema for the plugin
 */
function extension_delete_wsusinfo()
{
    $commonObject = new ExtensionCommon;
    $commonObject -> sqlQuery("DROP TABLE IF EXISTS `wsusinfo`");
}

/**
 * This function is called on plugin upgrade
 */
function extension_upgrade_wsusinfo()
{

}

?>