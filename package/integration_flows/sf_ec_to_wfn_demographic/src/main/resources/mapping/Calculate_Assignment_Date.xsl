<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://services.workforcesoftware.com/xsd"
	xmlns:ns1="http://ws.apache.org/axis2/xsd" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="ns1 xs">
	<xsl:output indent="yes" />
	
	
<xsl:template match="//ns1:assignment_end_date">
<xsl:variable name="vStartDate" select="."/>
<ns1:assignment_end_date>
  <xsl:value-of select="xs:date($vStartDate) - xs:dayTimeDuration('P1D')" />
</ns1:assignment_end_date>
</xsl:template>


	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*" />
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>