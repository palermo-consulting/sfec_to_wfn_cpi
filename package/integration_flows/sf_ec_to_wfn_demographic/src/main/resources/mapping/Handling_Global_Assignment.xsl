<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<queryCompoundEmployeeResponse>
			<xsl:for-each select="queryCompoundEmployeeResponse/CompoundEmployee">
				<!-- store Compound Employee minus person in a variable -->
				<xsl:variable name="var_compEmp" select="./*[not(name()='person')]" />
				<xsl:for-each select="person">
					<!-- store person minus employment information nodes in a variable -->
					<xsl:variable name="var_person"
						select="./*[not(name()='employment_information')]"></xsl:variable>

					<xsl:for-each select="employment_information">
					<!-- Ignore all GA employment information nodes-->
						<xsl:choose>
							<xsl:when
								test="assignment_class='GA'">
							</xsl:when>
							<!-- create a new compound employee for every filter-passed employment-information node  -->
							<xsl:otherwise>
								<xsl:variable name="var_empInfo" select="."></xsl:variable>
								<CompoundEmployee>
									<xsl:copy-of select="$var_compEmp" />
									<person>
										<xsl:copy-of select="$var_person" />
										<xsl:copy-of select="$var_empInfo" />
									</person>
								</CompoundEmployee>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:for-each>
		</queryCompoundEmployeeResponse>
	</xsl:template>
</xsl:stylesheet>