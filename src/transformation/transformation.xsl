<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:b="http://www.omg.org/spec/BPMN/20100524/MODEL"
    xmlns:activiti="http://activiti.org/bpmn">

	<xsl:output encoding="UTF-8" indent="yes" method="text" />

	<xsl:template match="/b:definitions/b:process">
	digraph {
		node [shape=box];
		<xsl:apply-templates select="b:*"/>
		}
</xsl:template>

<xsl:template match="b:extensionElements/b:monitoringGroup">
	<xsl:value-of select="@id"/> [shape=none, image="stereotype_monitoringGroup.png", label="<xsl:for-each select="b:monitoringVariable"><xsl:value-of select="@content"/>\n</xsl:for-each>", width=0.2, fontsize=10];
</xsl:template>


<xsl:template match="b:extensionElements/b:activityEffect">
	<xsl:value-of select="@id"/> [shape=none, image="stereotype_activitEffect.png", label="<xsl:for-each select="b:activityEffectRule"><xsl:value-of select="@rule"/>\n</xsl:for-each>", width=0.2, fontsize=10];
</xsl:template>


<xsl:template match="b:extensionElements/b:timeExpected">
	<xsl:value-of select="@id"/> [shape=none, image="stereotype_TimeExpected.png", label="\n\n\n\n\n<xsl:for-each select="b:param"><xsl:value-of select="@name"/>:<xsl:value-of select="@value"/><xsl:text> </xsl:text><xsl:value-of select="@unit"/>\n</xsl:for-each>", width=0.2, fontsize=10];
</xsl:template>



<xsl:template match="b:extensionElements/b:decisionQuestion">
	<xsl:value-of select="@id"/> [shape=none, image=<xsl:choose><xsl:when test="@type='quality'">"stereotype_decisionQuestionQuality.png"</xsl:when><xsl:otherwise>"stereotype_decisionQuestionNormal.png"</xsl:otherwise></xsl:choose>, label="\n\n\n\n<xsl:value-of select="@condition"/>", width=0.2 , fontsize=10];
</xsl:template>

	
<xsl:template match="b:extensionElements/b:association">
	<xsl:value-of select="@sourceRef"/> -> <xsl:value-of select="@targetRef"/> [style=dashed minlen=2];
	{rank=same;<xsl:value-of select="@sourceRef"/><xsl:text> </xsl:text><xsl:value-of select="@targetRef"/> };
</xsl:template>

<xsl:template match="b:sequenceFlow">
<xsl:variable name="sourceRef" select="@sourceRef"/>
<xsl:variable name="id" select="@id"/>
	<xsl:choose><xsl:when test="//b:extensionElements/b:association[@sourceRef=$id]"><xsl:value-of select="$id"/>[shape=point width=0]
	<xsl:value-of select="@sourceRef"/> -> <xsl:value-of select="$id"/> [label="" dir=none];
	<xsl:value-of select="$id"/> ->	<xsl:value-of select="@targetRef"/> [label=""];
	</xsl:when>
	<xsl:otherwise><xsl:value-of select="@sourceRef"/> -> <xsl:value-of select="@targetRef"/> [label=""];</xsl:otherwise>
</xsl:choose>
</xsl:template>
	

<xsl:template match="b:exclusiveGateway">
	<xsl:value-of select="@id"/> [label="X",fillcolor="#eeeeee",style=filled,width=0.75,height=0.75,fixedsize=true,shape="diamond"];
</xsl:template>
	
<xsl:template match="b:startEvent">
	<xsl:value-of select="@id"/> [shape=circle,style=filled,fillcolor=white,label="",width=0.2];
</xsl:template>


<xsl:template match="b:endEvent">
	<xsl:value-of select="@id"/> [shape=circle,style=filled,fillcolor=black,label="",width=0.2];
</xsl:template>

<xsl:template match="b:task">
	<xsl:value-of select="@id"/> [shape=box,style=filled,fillcolor="#ffffff",label="<xsl:value-of select="@name"/>",width=0.2];
</xsl:template>
</xsl:stylesheet>
