<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

	<xsl:output method="xml" encoding="UTF-8" indent="yes" />

	<xsl:param name="CurrentDate" />
	<xsl:param name="emplStatusA" />
	<xsl:param name="emplStatusT" />
	<xsl:param name="FixStartDate" />

	<xsl:template match="/">

		<xsl:variable name="rootEle" select="name(/*)" />

		<xsl:element name="{$rootEle}">

			<xsl:for-each select="queryCompoundEmployeeResponse/CompoundEmployee">

				<xsl:variable name="emp_var">
					<xsl:copy-of select="." />
				</xsl:variable>

				<xsl:if test="$CurrentDate != ''">

					<xsl:for-each select="person/employment_information/job_information">

						<xsl:if test="translate(end_date,'-','') &gt; $CurrentDate">

							<xsl:choose>
							
								<xsl:when test="emplStatus = $emplStatusT">

									<xsl:if test="translate(start_date,'-','') &gt;= $CurrentDate">

										<xsl:copy-of select="$emp_var" />

									</xsl:if>

								</xsl:when>

								<xsl:when test="emplStatus = $emplStatusA">

									<xsl:if test="translate(start_date,'-','') &lt;= $CurrentDate">
										
										<xsl:copy-of select="$emp_var" />
									
									</xsl:if>
								
								</xsl:when>

							</xsl:choose>

						</xsl:if>

					</xsl:for-each>

				</xsl:if>

				<xsl:if test="$CurrentDate = ''">

					<xsl:if
						test="./person/employment_information/job_information/emplStatus = $emplStatusA and translate(./person/employment_information/job_information/start_date,'-','') &gt; $FixStartDate">

						<xsl:value-of select="'true'" />

					</xsl:if>

				</xsl:if>

			</xsl:for-each>

		</xsl:element>

	</xsl:template>

</xsl:stylesheet>
