<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://services.workforcesoftware.com/xsd"
	xmlns:ns1="http://ws.apache.org/axis2/xsd">
	<xsl:output indent="yes" />

	<xsl:template
		match="//ns1:generic_field1 | //ns1:generic_field2 | //ns1:generic_field3 | //ns1:generic_field4 | //ns1:generic_field5 | //ns1:generic_field6 | //ns1:generic_field7 | //ns1:generic_field8 | //ns1:generic_field9 | //ns1:generic_field10 | //ns1:generic_field11 | //ns1:generic_field12 | //ns1:generic_field13 | //ns1:generic_field14 | //ns1:generic_field15 | //ns1:generic_field16 | //ns1:generic_field17 | //ns1:generic_field18 | //ns1:generic_field19 | //ns1:generic_field20 | //ns1:generic_field21 | //ns1:generic_field22 | //ns1:generic_field23 | //ns1:generic_field24 | //ns1:generic_field25">
		<ns1:generic_field>
			<ns1:fieldName>
				<xsl:value-of select="./ns1:fieldName" />
			</ns1:fieldName>
			<ns1:fieldValue>
				<xsl:value-of select="./ns1:fieldValue" />
			</ns1:fieldValue>
		</ns1:generic_field>
	</xsl:template>

	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*" />
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>