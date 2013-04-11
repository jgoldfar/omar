package omar.image.magick
import org.ossim.omar.core.Utility

class FooterGeneratorService
{
    def DEBUG = false
    def grailsApplication

    def serviceMethod( def footerAcquisitionDateText, def footerAcquisitionDateTextColor, def footerLocationText, def footerLocationTextColor, def footerSecurityClassificationText, def footerSecurityClassificationTextColor, def gradientColorBottom, def gradientColorTop, def imageHeight, def imageWidth )
    {
        def date = new Date().getTime()
        def tempFilesLocation = grailsApplication.config.export.workDir + "/"
        def tempFilesLocationAsFile = new File(tempFilesLocation)
        def tempFileFooter = File.createTempFile("footer",
                ".png", tempFilesLocationAsFile);
        def tempFileFooterSecurityClassificationText = File.createTempFile("footerSecurityClassificationText",
                ".png", tempFilesLocationAsFile);
        def tempFileFooterLocationText = File.createTempFile("footerSecurityClassificationText",
                ".png", tempFilesLocationAsFile);
        def tempFileFooterAcquisitionDateText = File.createTempFile("footerAcquisitionDateText",
                ".png", tempFilesLocationAsFile);
        def font = "web-app/fonts/ArialBold.ttf"

        //######################################################################################################################
        //################################################## Footer Generation ##################################################
        //######################################################################################################################
        if (DEBUG) { print "##### Footer Generation #####" }

        //########## Determine the footer size
        if (DEBUG) { println "Determine the footer size:" }
        def footerWidth = imageWidth
        footerWidth = footerWidth.toInteger()
        def footerHeight = 0.035 * imageHeight.toInteger()
        footerHeight = footerHeight.toInteger()
        if (DEBUG) { println "${footerWidth}x${footerHeight} pixels" }

        //########## Generate the blank footer
        if (DEBUG) { println "Generate the blank footer:" }
        def command = [
                "convert",
                "-size",
                "${footerWidth}x${footerHeight}",
                "gradient: #${gradientColorTop}-#${gradientColorBottom}",
                tempFileFooter.toString()
        ]
        if (DEBUG) { println "${command}" }
        executeCommand(command)

        //########## Determine the footer text size
        if (DEBUG) { println "Determine the footer text size:" }
        def footerTextWidth = footerWidth / 2
        footerTextWidth = footerTextWidth.toInteger()
        def footerTextHeight = footerHeight
        footerTextHeight = footerTextHeight.toInteger()
        if (DEBUG) { println "${footerTextWidth}x${footerTextHeight} pixels" }

        //########## Generate the footer security classification text
        if (DEBUG) { println "Generate the footer security classification text:" }
        command = [
                "convert",
                "-alpha",
                "set",
                "-background",
                "none",
                "-fill",
                "#${footerSecurityClassificationTextColor}",
                "-size",
                "${footerTextWidth}x${footerTextHeight}",
                "-gravity",
                "West",
                "-font",
                "${font}",
                "caption: ${footerSecurityClassificationText}",
                tempFileFooterSecurityClassificationText.toString()
        ]
        if (DEBUG) { println "${command}" }
        executeCommand(command)

        //########## Add the footer security classification text to the info banner
        if (DEBUG) { println "Add the footer security classification text to the footer:" }
        command = [
                "composite",
                tempFileFooterSecurityClassificationText.toString(),
                "-gravity",
                "West",
                tempFileFooter.toString(),
                tempFileFooter.toString()
        ]
        if (DEBUG) { println "${command}" }
        executeCommand(command)

        //########## Generate the footer location text
        if (DEBUG) { println "Generate the footer location text:" }
        command = [
                "convert",
                "-alpha",
                "set",
                "-background",
                "none",
                "-fill",
                "#${footerLocationTextColor}",
                "-size",
                "${footerTextWidth * 1.5}x${footerTextHeight}",
                "-gravity",
                "Center",
                "-font",
                "${font}",
                "caption:${footerLocationText}",
                tempFileFooterLocationText.toString()
        ]
        if (DEBUG) { println "${command}" }
        executeCommand(command)

        //########## Add the footer location text to the footer
        if (DEBUG) { println "Add the footer location text to the footer:" }
        command = [
                "composite",
                tempFileFooterLocationText.toString(),
                "-gravity",
                "Center",
                tempFileFooter.toString(),
                tempFileFooter.toString()
        ]
        if (DEBUG) { println "${command}" }
        executeCommand(command)

        //########## Generate the footer acquisition date text
        if (DEBUG) { println "Generate the footer acquisition date text:" }
        command = [
                "convert",
                "-alpha",
                "set",
                "-background",
                "none",
                "-fill",
                "#${footerAcquisitionDateTextColor}",
                "-size",
                "${footerTextWidth}x${footerTextHeight}",
                "-gravity",
                "East",
                "-font",
                "${font}",
                "caption:${footerAcquisitionDateText} ",
                tempFileFooterAcquisitionDateText.toString()
        ]
        if (DEBUG) { println "${command}" }
        executeCommand(command)

        //########## Add the footer acquisition date text to the footer
        if (DEBUG) { println "Add the footer banner acquisition date text to the footer:" }
        command = [
                "composite",
                tempFileFooterAcquisitionDateText.toString(),
                "-gravity",
                "East",
                tempFileFooter.toString(),
                tempFileFooter.toString()
        ]
        if (DEBUG) { println "${command}" }
        executeCommand(command)

        //####################################################################################################################
        //################################################## Disclaimer Text #################################################
        //####################################################################################################################
        if (DEBUG) { println "##### Disclaimer Text #####" }

        //########## Generate disclaimer text
        def disclaimerTextWidth = footerWidth
        def disclaimerTextHeight = footerHeight

        def disclaimerText = "Not an intelligence product  //  For informational use only  //  Not certified for targeting"
        if (DEBUG) { println "Generate disclaimer text:" }
        command = [
                "convert",
                tempFileFooter.toString(),
                "-background",
                "yellow",
                "-fill",
                "black",
                "-size",
                "${disclaimerTextWidth}x${disclaimerTextHeight}",
                "-gravity",
                "center",
                "-font",
                "${font}",
                "label:${disclaimerText}",
                "-append",
                tempFileFooter.toString()
        ]
        if (DEBUG) { println "${command}" }
        executeCommand(command)

        //#############################################################################################################################
        //################################################## Temporary File Deletion ##################################################
        //#############################################################################################################################
        tempFileFooterSecurityClassificationText.delete()
        tempFileFooterLocationText.delete()
        tempFileFooterAcquisitionDateText.delete()

        return tempFileFooter.toString()
    }

    def executeCommand(def executableCommand)
    {
        return Utility.executeCommand(executableCommand, true).text
    }
}
