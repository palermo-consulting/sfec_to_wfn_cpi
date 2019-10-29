<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns2="http://ws.apache.org/axis2/xsd">

	<!-- Identity transform -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="person">
	<ns2:person>
       <xsl:apply-templates />
     </ns2:person>
	</xsl:template>

</xsl:stylesheet>