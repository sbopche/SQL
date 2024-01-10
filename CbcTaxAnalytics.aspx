<%@ Page Title="" Language="C#" MasterPageFile="~/TaxDNAMaster.Master" AutoEventWireup="true" CodeBehind="CbcTaxAnalytics.aspx.cs" Inherits="KPMG.ITS.TAXDNA.CbcAnalytics.CbcTaxAnalytics" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ MasterType VirtualPath="~/TaxDNAMaster.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        function ShowPopup() {
            $("#btnShowPopup").click();
        }

        function pageLoad() {
            var MainRadHtmlChart = $find("<%=MainRadHtmlChart.ClientID%>");
            MainRadHtmlChart._chartObject.bind("axisLabelClick", MainRadHtmlChart_axisLabelClick);
        }

        function MainRadHtmlChart_axisLabelClick(e) {
            $("#ContentPlaceHolder1_TxtMainRadHtmlChart").val(e?.value);
            $("#<%=BtnMainRadHtmlChart.ClientID%>").click();
        }

        function OnMainRadHtmlChartSeriesClickdt(sender, eventArgs) {
            $("#ContentPlaceHolder1_TxtMainRadHtmlChart").val(sender?.category);
            $("#<%=MainRadHtmlChart.ClientID%>").click();
        }

        function ddlAnalytics_OnClientDropDownClosing(sender, eventArgs) {
            $("#<%=BtnGetClientsFromAnalytics.ClientID%>").click();
        }

        function ddlPeriod_OnClientDropDownClosing(sender, eventArgs) {
            $("#<%=BtnGetCountryFromPeriod.ClientID%>").click();
        }

        function ddlCountries_OnClientDropDownClosing(sender, eventArgs) {
            console.log(sender.Text);
            $("#<%=BtnGetEntityFromCountry.ClientID%>").click();
        }

        function ddlCurrency_OnClientDropDownClosing(sender, eventArgs) {
            $("#<%=BtnGetCurrency.ClientID%>").click();
        }

        function ddlEntity_OnClientDropDownClosing(sender, eventArgs) {
            $("#<%=BtnGetEntity.ClientID%>").click();
        }

        function ddlSelectType_OnClientDropDownClosing(sender, eventArgs) {
            $("#<%=BtnGetClientsFromAnalytics.ClientID%>").click();
        }

        // This Function is Used To remove 0 values from chart label called inside ClientTemplate...
        function FormatChartLabel(columnValue) {
            if (columnValue == 0 || columnValue == 0.00) {
                return '';
            }
            else {
                return columnValue;
            }
        }

        // This Function is Used To remove 0 values from chart label called inside ClientTemplate and Used to convert digits to T,B,M,K...
        function ConvertToMBKChartLabel(columnValue) {
            if (columnValue == 0 || columnValue == 0.00) {
                return '';
            }

            const abbreviations = ['', 'K', 'M', 'B', 'T'];

            let magnitude = 0;
            while (columnValue >= 1000 && magnitude < abbreviations.length - 1) {
                columnValue /= 1000;
                magnitude++;
            }

            const formattedNumber = (magnitude > 0 ? columnValue.toFixed(1) : Math.floor(columnValue)) + abbreviations[magnitude];
            return formattedNumber;
        }
        // Y-axis Label 
        function ConvertToMBKChartLabelWithZeroPercesion(columnValue) {
            if (columnValue == 0 || columnValue == 0.00) {
                return '';
            }

            const abbreviations = ['', 'K', 'M', 'B', 'T'];

            let magnitude = 0;
            while (columnValue >= 1000 && magnitude < abbreviations.length - 1) {
                columnValue /= 1000;
                magnitude++;
            }

            const formattedNumber = (magnitude > 0 ? columnValue.toFixed(0) : Math.floor(columnValue)) + abbreviations[magnitude];
            return formattedNumber;
        }
    </script>

    <style type="text/css">
        #ctl00_ContentPlaceHolder1_TotalHeaderRadGrid {
            background-color: #b3ccec;
        }

            #ctl00_ContentPlaceHolder1_TotalHeaderRadGrid tr {
                width: 100%;
                background-color: #b3ccec;
                justify-content: center;
            }

                #ctl00_ContentPlaceHolder1_TotalHeaderRadGrid tr td {
                    background-color: #b3ccec;
                    text-align: center;
                }

                    #ctl00_ContentPlaceHolder1_TotalHeaderRadGrid tr td .main-header-class {
                        color: #000000;
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        margin-bottom: 1px !important;
                        font-size: 1rem;
                    }

                    #ctl00_ContentPlaceHolder1_TotalHeaderRadGrid tr td .sub-header-class {
                        color: #000000;
                        font-weight: 600;
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        margin-bottom: 1px !important;
                    }


        #ctl00_ContentPlaceHolder1_SubTotalHeaderRadGrid {
            background-color: #b3ccec;
        }

            #ctl00_ContentPlaceHolder1_SubTotalHeaderRadGrid tr {
                width: 100%;
                background-color: #b3ccec;
                justify-content: center;
            }

                #ctl00_ContentPlaceHolder1_SubTotalHeaderRadGrid tr td {
                    background-color: #b3ccec;
                    text-align: center;
                }

                    #ctl00_ContentPlaceHolder1_SubTotalHeaderRadGrid tr td .main-header-class {
                        color: #000000;
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        margin-bottom: 1px !important;
                        font-size: 1rem;
                    }

                    #ctl00_ContentPlaceHolder1_SubTotalHeaderRadGrid tr td .sub-header-class {
                        color: #000000;
                        font-weight: 600;
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        margin-bottom: 1px !important;
                    }

        div.RadComboBoxDropDown_Vista .rcbSeparator {
            background: none;
            font-weight: 600;
            font-size: 1rem;
        }

            div.RadComboBoxDropDown_Vista .rcbSeparator label {
                background: none;
                font-weight: 600;
                font-size: 1rem;
            }

        div.RadComboBoxDropDown_Vista .rcbItem, div.RadComboBoxDropDown_Vista .rcbHovered {
            padding-left: 20px;
            font-family: Arial;
            font-size: 10pt;
        }
    </style>

    <div class="container" id="divFilterSection">
        <div class="row">
            <div class="col-12">
                <div class="card shadow mb-4 mt-1 rounded fadeInUp">
                    <a href="#collapseCard2" class="d-block card-header py-2 bg-info" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="collapseCard2">
                        <h4 class="m-0 text-white small">Filters</h4>
                    </a>
                    <div class="collapse show" id="collapseCard2" style="">
                        <div class="card-body">
                            <div class="row">
                                <div id="divAnalytics" runat="server" class="form-group col-sm-3 small">
                                    <label><i class="fa fa-group mr-1" style="color: #47bac1;"></i><b>Analytics</b></label>
                                    <div class="input-group col-sm-12">
                                        <telerik:RadComboBox RenderMode="Lightweight" Filter="Contains" ID="AnalyticsRadComboBox"
                                            runat="server" Font-Bold="true" EmptyMessage="--Select Analytics--" CheckBoxes="false"
                                            OnClientDropDownClosing="ddlAnalytics_OnClientDropDownClosing"
                                            Width="280" DropDownAutoWidth="Enabled">
                                            <Localization ItemsCheckedString="Analytics Selected" />
                                        </telerik:RadComboBox>
                                    </div>
                                </div>

                                <div id="divPeriod" runat="server" class="form-group col-sm-3 small">
                                    <label><i class="fa fa-group mr-1" style="color: #47bac1;"></i><b>Period</b></label>
                                    <div class="input-group col-sm-12">
                                        <telerik:RadComboBox RenderMode="Lightweight" Filter="Contains" runat="server" ID="RadPeriod"
                                            Font-Bold="true" EmptyMessage="--Select Period--" CheckBoxes="false"
                                            OnClientDropDownClosing="ddlPeriod_OnClientDropDownClosing"
                                            Width="280" DropDownAutoWidth="Enabled">
                                            <Localization ItemsCheckedString="Period Selected" />
                                        </telerik:RadComboBox>
                                    </div>
                                </div>

                                <div id="divCountry" runat="server" class="form-group col-sm-3 small">
                                    <label><i class="fa fa-group mr-1" style="color: #47bac1;"></i><b>Country</b></label>
                                    <telerik:RadCheckBox ID="chkTop10Jurisdictions" runat="server" Text="Top 10" OnCheckedChanged="chkTop10Jurisdictions_CheckedChanged"></telerik:RadCheckBox>
                                    <telerik:RadCheckBox ID="chkTop5Jurisdictions" runat="server" Text="Top 5" OnCheckedChanged="chkTop5Jurisdictions_CheckedChanged"></telerik:RadCheckBox>

                                    <div class="input-group col-sm-12">
                                        <telerik:RadComboBox RenderMode="Lightweight" Filter="Contains" ID="RadCountry" AllowCustomText="true" Skin="Vista"
                                            runat="server" Font-Bold="true" EmptyMessage="--Select Country--" CheckBoxes="true"
                                            OnClientDropDownClosing="ddlCountries_OnClientDropDownClosing"
                                            EnableCheckAllItemsCheckBox="true" Width="280" DropDownAutoWidth="Enabled">
                                            <Localization ItemsCheckedString="Countries Selected" />
                                            <Localization AllItemsCheckedString=" All Countries Selected" />
                                        </telerik:RadComboBox>
                                    </div>
                                </div>

                                <div id="divCurrency" runat="server" class="form-group col-sm-3 small">
                                    <label><i class="fa fa-group mr-1" style="color: #47bac1;"></i><b>Currency</b></label>
                                    <div class="input-group col-sm-12">
                                        <telerik:RadComboBox RenderMode="Lightweight" Filter="Contains" ID="RadCurrency"
                                            runat="server" Font-Bold="true" EmptyMessage="--Select Currency--" CheckBoxes="false"
                                            OnClientDropDownClosing="ddlCurrency_OnClientDropDownClosing"
                                            EnableCheckAllItemsCheckBox="false" Width="280" DropDownAutoWidth="Enabled">
                                            <Localization ItemsCheckedString="Currency Selected" />
                                        </telerik:RadComboBox>
                                    </div>
                                </div>

                                <div id="divEntity" runat="server" class="form-group col-sm-3 small">
                                    <label><i class="fa fa-group mr-1" style="color: #47bac1;"></i><b>Entity Name</b></label>
                                    <div class="input-group col-sm-12">
                                        <telerik:RadComboBox AutoPostBack="True"
                                            RenderMode="Lightweight" Filter="Contains" ID="RadClientEntity"
                                            runat="server" Font-Bold="true" EmptyMessage="--Select Entity--" CheckBoxes="true"
                                            OnClientDropDownClosing="ddlEntity_OnClientDropDownClosing"
                                            EnableCheckAllItemsCheckBox="true" Width="400px"
                                            DropDownAutoWidth="Enabled">
                                            <Localization ItemsCheckedString="Entities Selected" />
                                            <Localization AllItemsCheckedString=" All Entities Selected" />
                                        </telerik:RadComboBox>
                                    </div>
                                </div>

                                <div class="form-group small mt-auto" style="text-align: right!important; margin-left: 50px;">
                                    <asp:Button ID="btnfilter" runat="server" Text="Filter" class="btn btn-sm rounded ml-3 btn btn-purple"
                                        OnClientClick="showloader(); return Validate(); "
                                        OnClick="BtnFilter_Click" />
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>

    <div class="container" id="divSelectType" runat="server">
        <div class="row">
            <div class="col-sm-3 form-group small" runat="server">
                <label><b>Select Type</b></label>
                <div class="input-group">
                    <telerik:RadComboBox RenderMode="Lightweight" Filter="Contains" ID="SelectedTypeRadComboBox"
                        runat="server" Font-Bold="true" EmptyMessage="--Select Type--" CheckBoxes="false"
                        OnClientDropDownClosing="ddlSelectType_OnClientDropDownClosing"
                        Width="280" DropDownAutoWidth="Enabled">
                        <Localization ItemsCheckedString="Type Selected" />
                    </telerik:RadComboBox>
                </div>
            </div>

            <div class=" col-sm-3 form-group small" style="margin-top: 25px;" runat="server" id="BtnHideDrillDown">
                <asp:Button ID="Button1" runat="server" Text="Clear Drill Down" class="btn btn-sm rounded ml-3 btn btn-default"
                    OnClick="BtnHideDrillDown_Click" />
            </div>
        </div>
        <div class="clearfix"></div>
    </div>

    <div class="row" id="divAnalyticsSection">
        <div class="col-12">

            <div class="container" id="divTotalCountSection" runat="server">
                <div class="row">
                    <div class="col-12">
                        <telerik:RadLabel runat="server" ID="lblAmountIn" Font-Bold="true" ForeColor="#16498c" Style="display: flex; justify-content: left; font-size: 1rem; margin-bottom: 0.5rem">
                        </telerik:RadLabel>

                        <telerik:RadGrid RenderMode="Lightweight" ID="TotalHeaderRadGrid" runat="server"
                            HeaderStyle-HorizontalAlign="Center"
                            AutoGenerateColumns="true"
                            OnItemDataBound="TotalHeaderRadGrid_ItemDataBound">
                            <MasterTableView ShowHeader="false" AlternatingItemStyle-Font-Bold="true">
                            </MasterTableView>
                        </telerik:RadGrid>

                        <telerik:RadLabel runat="server" ID="LblMainRadHtmlChart" Font-Bold="true" ForeColor="#16498c" Style="display: flex; justify-content: center; font-size: 1.5rem; margin-top: 0.5rem">
                        </telerik:RadLabel>
                    </div>
                </div>
            </div>

            <%--Main Chart--%>
            <div class="clsMainRadHtmlChart" id="IdMainRadHtmlChart" style="overflow-x: scroll; width: 1300px" runat="server">
                <telerik:RadHtmlChart runat="server" ID="MainRadHtmlChart" Transitions="true" Visible="false" Height="400px" Width="2000px">
                    <ClientEvents OnSeriesClick="OnMainRadHtmlChartSeriesClickdt" />
                    <Legend>
                        <Appearance Position="Top" Align="Center" BackgroundColor="Transparent">
                            <TextStyle Bold="true" FontSize="15" FontFamily="Segoe UI" Margin="10 10 20 10" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis>
                            <LabelsAppearance>
                                <TextStyle Bold="true" FontFamily="Segoe UI" />
                            </LabelsAppearance>
                            <MinorGridLines Visible="false" />
                        </XAxis>
                    </PlotArea>
                    <PlotArea>
                        <YAxis>
                            <LabelsAppearance>
                                <TextStyle Bold="true" FontFamily="Segoe UI" />
                            </LabelsAppearance>
                            <MinorGridLines Visible="false" />
                            <MajorGridLines Visible="false" />
                        </YAxis>
                    </PlotArea>
                </telerik:RadHtmlChart>
            </div>

            <div class="container" id="divSubTotalCountSection" runat="server" style="margin-top: 1rem;">
                <div class="row">
                    <div class="col-12">
                        <telerik:RadGrid RenderMode="Lightweight" ID="SubTotalHeaderRadGrid" runat="server"
                            HeaderStyle-HorizontalAlign="Center"
                            AutoGenerateColumns="true"
                            OnItemDataBound="SubTotalHeaderRadGrid_ItemDataBound">
                            <MasterTableView ShowHeader="false" AlternatingItemStyle-Font-Bold="true">
                            </MasterTableView>
                        </telerik:RadGrid>

                        <telerik:RadLabel runat="server" ID="LblDrillDownRadHtmlChart" Font-Bold="true" ForeColor="#16498c" Style="display: flex; justify-content: center; font-size: 1.5rem; margin-top: 0.5rem">
                        </telerik:RadLabel>
                    </div>
                </div>
            </div>

            <%--Drill-Down--%>
            <div class="clsDrillDownRadHtmlChart" id="IdDrillDownRadHtmlChart" style="overflow-x: scroll; width: 1300px" runat="server">
                <telerik:RadHtmlChart runat="server" ID="DrillDownRadHtmlChart" Transitions="true" Visible="false" Height="400px" Width="2000px">
                    <Legend>
                        <Appearance Position="Top" Align="Center" BackgroundColor="Transparent">
                            <TextStyle Bold="true" FontSize="15" FontFamily="Segoe UI" Margin="10 10 20 10" />
                        </Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis>
                            <LabelsAppearance>
                                <TextStyle Bold="true" FontFamily="Segoe UI" />
                            </LabelsAppearance>
                            <MinorGridLines Visible="false" />
                        </XAxis>
                    </PlotArea>
                    <PlotArea>
                        <YAxis>
                            <LabelsAppearance>
                                <TextStyle Bold="true" FontFamily="Segoe UI" />
                            </LabelsAppearance>
                            <MinorGridLines Visible="false" />
                            <MajorGridLines Visible="false" />
                        </YAxis>
                    </PlotArea>
                </telerik:RadHtmlChart>
            </div>
        </div>
    </div>

    <div class="container" id="Overviewoftop10jurisdiction" runat="server">
        <div class="row">
            <div class="col-12">
                <%--Overview of top 10 jurisdiction--%>
                <telerik:RadGrid RenderMode="Lightweight" runat="server" ID="RadGridOfOverviewoftop10jurisdiction" HeaderStyle-HorizontalAlign="Center" AutoGenerateColumns="false" OnItemDataBound="RadGridOfOverviewoftop10jurisdiction_ItemDataBound">
                    <MasterTableView>
                        <Columns>
                            <telerik:GridBoundColumn DataField="TaxJurisdiction" UniqueName="TaxJurisdiction" HeaderText="Tax Jurisdiction" ReadOnly="true">
                                <HeaderStyle ForeColor="White" BackColor="#16498c" Font-Bold="true" />
                                <ItemStyle BackColor="#beeef6" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ETR" UniqueName="ETR" HeaderText="ETR" ReadOnly="true">
                                <HeaderStyle HorizontalAlign="Center" ForeColor="White" BackColor="#16498c" Font-Bold="true" />
                                <ItemStyle HorizontalAlign="Center" BackColor="#beeef6" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PBT" UniqueName="PBT" HeaderText="PBT / Sales %" ReadOnly="true">
                                <HeaderStyle HorizontalAlign="Center" ForeColor="White" BackColor="#16498c" Font-Bold="true" />
                                <ItemStyle HorizontalAlign="Center" BackColor="#beeef6" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="JurisdictionRevenueMoney" UniqueName="JurisdictionRevenueMoney" HeaderText="Jurisdiction revenue" ReadOnly="true">
                                <HeaderStyle HorizontalAlign="Center" ForeColor="White" BackColor="#16498c" Font-Bold="true" />
                                <ItemStyle HorizontalAlign="right" BackColor="#beeef6" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RevenuePercentageGroupRevenue" UniqueName="RevenuePercentageGroupRevenue" HeaderText="Jurisdiction revenue to Total revenue %" HeaderStyle-Width="170px" ReadOnly="true">
                                <HeaderStyle HorizontalAlign="Center" ForeColor="White" BackColor="#16498c" Font-Bold="true" />
                                <ItemStyle HorizontalAlign="Center" BackColor="#beeef6" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RPRPercentageJurisdictionRevenue" UniqueName="RPRPercentageJurisdictionRevenue" HeaderText="RPR to Own revenue %" ReadOnly="true">
                                <HeaderStyle HorizontalAlign="Center" ForeColor="White" BackColor="#16498c" Font-Bold="true" />
                                <ItemStyle HorizontalAlign="Center" BackColor="#beeef6" />
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </div>
    </div>

    <div class="row" id="divHiddenEventSection">
        <div class="col-12">
            <div style="display: none;">
                <asp:TextBox ID="TxtMainRadHtmlChart" runat="server" />
            </div>
            <div style="display: none;">
                <asp:Button ID="BtnMainRadHtmlChart" runat="server" OnClick="BtnMainRadHtmlChart_Click" />
            </div>
            <div style="display: none;">
                <asp:Button ID="BtnGetCountryFromPeriod" runat="server" OnClick="BtnGetCountryFromPeriod_Click" />
            </div>
            <div style="display: none;">
                <asp:Button ID="BtnGetClientsFromAnalytics" runat="server" OnClick="BtnGetClientsFromAnalytics_Click" />
            </div>
            <div style="display: none;">
                <asp:Button ID="BtnGetEntityFromCountry" runat="server" OnClick="BtnGetEntityFromCountry_Click" />
            </div>
            <div style="display: none;">
                <asp:Button ID="BtnGetCurrency" runat="server" OnClick="BtnGetCurrency_Click" />
            </div>
            <div style="display: none;">
                <asp:Button ID="BtnGetEntity" runat="server" OnClick="BtnGetEntity_Click" />
            </div>
        </div>
    </div>

    <div class="row" id="divModalPopUpSection">
        <button type="button" style="display: none;" id="btnShowPopup" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal1">Launch demo modal</button>
        <div class="modal fade" id="myModal1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true" style="color: #ffffff">&times;</span></button>
                    </div>
                    <div class="modal-body" style="text-align: center;">
                        <asp:Label ID="lblMessage" runat="server" Font-Bold="true"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
