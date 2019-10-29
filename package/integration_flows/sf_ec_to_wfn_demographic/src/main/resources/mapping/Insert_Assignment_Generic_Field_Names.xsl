<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://services.workforcesoftware.com/xsd"
	xmlns:ns1="http://ws.apache.org/axis2/xsd" exclude-result-prefixes="ns1">
	<xsl:output indent="yes" />
	<xsl:param name="Assignment_Generic_Field_Name_1" />
	<xsl:param name="Assignment_Generic_Field_Name_2" />
	<xsl:param name="Assignment_Generic_Field_Name_3" />
	<xsl:param name="Assignment_Generic_Field_Name_4" />
	<xsl:param name="Assignment_Generic_Field_Name_5" />
	<xsl:param name="Assignment_Generic_Field_Name_6" />
	<xsl:param name="Assignment_Generic_Field_Name_7" />
	<xsl:param name="Assignment_Generic_Field_Name_8" />
	<xsl:param name="Assignment_Generic_Field_Name_9" />
	<xsl:param name="Assignment_Generic_Field_Name_10" />
	<xsl:param name="Assignment_Generic_Field_Name_11" />
	<xsl:param name="Assignment_Generic_Field_Name_12" />
	<xsl:param name="Assignment_Generic_Field_Name_13" />
	<xsl:param name="Assignment_Generic_Field_Name_14" />
	<xsl:param name="Assignment_Generic_Field_Name_15" />
	<xsl:param name="Assignment_Generic_Field_Name_16" />
	<xsl:param name="Assignment_Generic_Field_Name_17" />
	<xsl:param name="Assignment_Generic_Field_Name_18" />
	<xsl:param name="Assignment_Generic_Field_Name_19" />
	<xsl:param name="Assignment_Generic_Field_Name_20" />
	<xsl:param name="Assignment_Generic_Field_Name_21" />
	<xsl:param name="Assignment_Generic_Field_Name_22" />
	<xsl:param name="Assignment_Generic_Field_Name_23" />
	<xsl:param name="Assignment_Generic_Field_Name_24" />
	<xsl:param name="Assignment_Generic_Field_Name_25" />
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields">
		<!-- Do not create the ns1:generic_field node if none of the external generic field names have values -->
		<xsl:if
			test="$Assignment_Generic_Field_Name_1 != '' 
		 or $Assignment_Generic_Field_Name_2 != ''
		 or $Assignment_Generic_Field_Name_3 != ''
		 or $Assignment_Generic_Field_Name_4 != ''
		 or $Assignment_Generic_Field_Name_5 != ''
		 or $Assignment_Generic_Field_Name_6 != ''
		 or $Assignment_Generic_Field_Name_7 != '' 
		 or $Assignment_Generic_Field_Name_8 != '' 
		 or $Assignment_Generic_Field_Name_9 != '' 
		 or $Assignment_Generic_Field_Name_10 != '' 
		 or $Assignment_Generic_Field_Name_11 != '' 
		 or $Assignment_Generic_Field_Name_12 != '' 
		 or $Assignment_Generic_Field_Name_13 != '' 
		 or $Assignment_Generic_Field_Name_14 != '' 
		 or $Assignment_Generic_Field_Name_15 != '' 
		 or $Assignment_Generic_Field_Name_16 != '' 
		 or $Assignment_Generic_Field_Name_17 != '' 
		 or $Assignment_Generic_Field_Name_18 != '' 
		 or $Assignment_Generic_Field_Name_19 != '' 
		 or $Assignment_Generic_Field_Name_20 != '' 
		 or $Assignment_Generic_Field_Name_21 != '' 
		 or $Assignment_Generic_Field_Name_22 != '' 
		 or $Assignment_Generic_Field_Name_23 != '' 
		 or $Assignment_Generic_Field_Name_24 != '' 
		 or $Assignment_Generic_Field_Name_25 != ''">
			<xsl:copy>
				<xsl:apply-templates select="node()|@*" />
			</xsl:copy>
		</xsl:if>
	</xsl:template>

	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field1">
		<xsl:if test="$Assignment_Generic_Field_Name_1 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_1 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field2">
		<xsl:if test="$Assignment_Generic_Field_Name_2 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_2 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field3">
		<xsl:if test="$Assignment_Generic_Field_Name_3 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_3 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field4">
		<xsl:if test="$Assignment_Generic_Field_Name_4 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_4 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field5">
		<xsl:if test="$Assignment_Generic_Field_Name_5 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_5 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field6">
		<xsl:if test="$Assignment_Generic_Field_Name_6 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_6 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field7">
		<xsl:if test="$Assignment_Generic_Field_Name_7 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_7 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>

	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field8">
		<xsl:if test="$Assignment_Generic_Field_Name_8 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_8 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field9">
		<xsl:if test="$Assignment_Generic_Field_Name_9 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_9 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field10">
		<xsl:if test="$Assignment_Generic_Field_Name_10 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_10 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field11">
		<xsl:if test="$Assignment_Generic_Field_Name_11 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_11 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field12">
		<xsl:if test="$Assignment_Generic_Field_Name_12 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_12 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field13">
		<xsl:if test="$Assignment_Generic_Field_Name_13 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_13 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field14">
		<xsl:if test="$Assignment_Generic_Field_Name_14 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_14 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field15">
		<xsl:if test="$Assignment_Generic_Field_Name_15 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_15 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field16">
		<xsl:if test="$Assignment_Generic_Field_Name_16 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_16 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field17">
		<xsl:if test="$Assignment_Generic_Field_Name_17 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_17 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field18">
		<xsl:if test="$Assignment_Generic_Field_Name_18 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_18 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field19">
		<xsl:if test="$Assignment_Generic_Field_Name_19 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_19 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field20">
		<xsl:if test="$Assignment_Generic_Field_Name_20 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_20 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field21">
		<xsl:if test="$Assignment_Generic_Field_Name_21 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_21 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field22">
		<xsl:if test="$Assignment_Generic_Field_Name_22 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_22 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field23">
		<xsl:if test="$Assignment_Generic_Field_Name_23 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_23 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field24">
		<xsl:if test="$Assignment_Generic_Field_Name_24 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_24 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//ns1:employee_data/ns1:assignment/ns1:eff_dated_info/ns1:data/ns1:generic_fields/ns1:generic_field25">
		<xsl:if test="$Assignment_Generic_Field_Name_25 != ''">
			<ns1:generic_field>
				<ns1:fieldName>
					<xsl:value-of select="$Assignment_Generic_Field_Name_25 " />
				</ns1:fieldName>
				<ns1:fieldValue>
					<xsl:value-of select="./ns1:fieldValue" />
				</ns1:fieldValue>
			</ns1:generic_field>
		</xsl:if>
	</xsl:template>

	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*" />
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>