<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="xs">


	<xsl:template match="/">
		<queryCompoundEmployeeResponse>
			<xsl:for-each select="queryCompoundEmployeeResponse/CompoundEmployee">
				<xsl:variable name="var_compEmp" select="." />

				<xsl:for-each select="./person/employment_information">
					<xsl:if test="xs:date(./job_information[1]/start_date) &gt; current-date()">
						<xsl:copy-of select="$var_compEmp" />
					</xsl:if>
				</xsl:for-each>

			</xsl:for-each>
		</queryCompoundEmployeeResponse>
	</xsl:template>
</xsl:stylesheet>