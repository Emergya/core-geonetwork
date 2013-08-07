<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl ="http://www.w3.org/1999/XSL/Transform"
	xmlns:gmd="http://www.isotc211.org/2005/gmd"
	xmlns:gts="http://www.isotc211.org/2005/gts"
	xmlns:gco="http://www.isotc211.org/2005/gco"
	xmlns:gmx="http://www.isotc211.org/2005/gmx"
	xmlns:srv="http://www.isotc211.org/2005/srv"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:gml="http://www.opengis.net/gml"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:gn="http://www.fao.org/geonetwork"
	xmlns:gn-fn-metadata="http://geonetwork-opensource.org/xsl/functions/metadata"
	xmlns:gn-fn-iso19139="http://geonetwork-opensource.org/xsl/functions/profiles/iso19139"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="#all">
	
	<xsl:include href="mapping.xsl"/>
	
	
	<!-- Could we define a tab configuration ? -->
	<xsl:variable name="tabConfig">
		<tab id="default">
			<section match="gmd:identificationInfo"/>
			<section match="gmd:distributionInfo"/>
			<section match="gmd:dataQualityInfo"/>
			<section match="gmd:MD_Metadata"/>
		</tab>
	</xsl:variable>
	
	
	<!-- Dispatching to the profile mode according to the tab -->
	<xsl:template name="render-iso19139">
		<xsl:param name="base" as="node()"/>
		
		<xsl:variable name="theTabConfiguration" select="$tabConfig/tab[@id = $tab]/section"/>
		
		<xsl:choose>
			<xsl:when test="$theTabConfiguration">
				<xsl:for-each select="$theTabConfiguration">
					<xsl:variable name="matchingElement" select="@match"/>
					<xsl:apply-templates mode="mode-iso19139" select="$base/*[name() = $matchingElement]"/>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$tab = 'xml'">
				<xsl:apply-templates mode="render-xml" select="$base"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates mode="mode-iso19139" select="$base"/>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	
</xsl:stylesheet>
