<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" />
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="/Record/Elements/WorkTelephone">
		<xsl:variable name="in" select="." />
		<WorkTelephone>
			<xsl:value-of select="substring(replace($in,'[^0-9]',''),1,10)" />
		</WorkTelephone>
	</xsl:template>
	
	
	<xsl:template match="/Record/Elements/MobileNumber">
		<xsl:variable name="in" select="." />
		<MobileNumber>
			<xsl:value-of select="substring(replace($in,'[^0-9]',''),1,10)" />
		</MobileNumber>
	</xsl:template>
	
	
	<xsl:template match="/Record/Elements/HomeTelephone">
		<xsl:variable name="in" select="." />
		<HomeTelephone>
			<xsl:value-of select="substring(replace($in,'[^0-9]',''),1,10)" />
		</HomeTelephone>
	</xsl:template>


	<xsl:template match="/Record/Elements/Address1">
		<xsl:variable name="in" select="." />
		<Address1>
			<xsl:value-of select="substring($in,1,50)" />
		</Address1>
	</xsl:template>
	<xsl:template match="/Record/Elements/Address2">
		<xsl:variable name="in" select="." />
		<Address2>
			<xsl:value-of select="substring($in,1,50)" />
		</Address2>
	</xsl:template>

	<xsl:template match="/Record/Elements/Address3">
		<xsl:variable name="in" select="." />
		<Address3>
			<xsl:value-of select="substring($in,1,50)" />
		</Address3>
	</xsl:template>

	<xsl:template match="/Record/Elements/Address4">
		<xsl:variable name="in" select="." />
		<Address4>
			<xsl:value-of select="substring($in,1,50)" />
		</Address4>
	</xsl:template>

</xsl:stylesheet>