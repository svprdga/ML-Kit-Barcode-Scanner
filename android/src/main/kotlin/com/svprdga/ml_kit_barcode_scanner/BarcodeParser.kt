package com.svprdga.ml_kit_barcode_scanner

import android.util.Log
import com.google.mlkit.vision.barcode.Barcode
import org.json.JSONObject

class BarcodeParser {

    // ************************************* PUBLIC METHODS ************************************ //

    fun parseBarcode(barcode: Barcode): JSONObject {
        val map: MutableMap<String, Any> = mutableMapOf()

        map["rawValue"] = barcode.rawValue
        map["valueType"] = barcode.valueType

        // Calendar
        when (barcode.valueType) {
            Barcode.TYPE_CALENDAR_EVENT -> {
                map["calendarDescription"] = barcode.calendarEvent.description
                map["calendarEnd"] = barcode.calendarEvent.end.rawValue
                map["calendarLocation"] = barcode.calendarEvent.location
                map["calendarOrganizer"] = barcode.calendarEvent.organizer
                map["calendarStart"] = barcode.calendarEvent.start.rawValue
                map["calendarStatus"] = barcode.calendarEvent.status
                map["calendarSummary"] = barcode.calendarEvent.summary
            }

            // Contact
            Barcode.TYPE_CONTACT_INFO -> {

                // Addresses
                val addressesMap: MutableMap<String, Any> = mutableMapOf()
                barcode.contactInfo.addresses.forEach { address ->
                    addressesMap["type"] = address.type
                    addressesMap["addressLine"] = address.addressLines
                }
                map["contactAddresses"] = addressesMap

                // Emails
                val emailsList = mutableListOf<Map<String, Any>>()
                barcode.contactInfo.emails.forEach { email ->
                    emailsList.add(
                        mapOf(
                            "type" to email.type,
                            "subject" to email.subject,
                            "body" to email.body,
                            "address" to email.address
                        )
                    )
                }
                map["contactEmails"] = emailsList

                // Name
                val namesMap: MutableMap<String, Any> = mutableMapOf(
                    "first" to barcode.contactInfo.name.first,
                    "formattedName" to barcode.contactInfo.name.formattedName,
                    "middle" to barcode.contactInfo.name.middle,
                    "last" to barcode.contactInfo.name.last,
                    "prefix" to barcode.contactInfo.name.prefix,
                    "pronunciation" to barcode.contactInfo.name.pronunciation,
                    "suffix" to barcode.contactInfo.name.suffix
                )
                map["contactName"] = namesMap

                // Phones
                val phonesList = mutableListOf<Map<String, Any>>()
                barcode.contactInfo.phones.forEach { phone ->
                    phonesList.add(
                        mapOf(
                            "type" to phone.type,
                            "number" to phone.number
                        )
                    )
                }
                map["contactPhones"] = phonesList

                // Other
                map["contactUrls"] = barcode.contactInfo.urls
                map["contactOrganization"] = barcode.contactInfo.organization.first()
                map["contactTitle"] = barcode.contactInfo.title
            }

            // Driver license
            Barcode.TYPE_DRIVER_LICENSE -> {
                map["driverLicenseAddressCity"] = barcode.driverLicense.addressCity
                map["driverLicenseAddressState"] = barcode.driverLicense.addressState
                map["driverLicenseAddressStreet"] = barcode.driverLicense.addressStreet
                map["driverLicenseAddressZip"] = barcode.driverLicense.addressZip
                map["driverLicenseBirthDate"] = barcode.driverLicense.birthDate
                map["driverLicenseDocumentType"] = barcode.driverLicense.documentType
                map["driverLicenseExpiryDate"] = barcode.driverLicense.expiryDate
                map["driverLicenseFirstName"] = barcode.driverLicense.firstName
                map["driverLicenseGender"] = barcode.driverLicense.gender
                map["driverLicenseIssueDate"] = barcode.driverLicense.issueDate
                map["driverLicenseIssuingCountry"] = barcode.driverLicense.issuingCountry
                map["driverLicenseLastName"] = barcode.driverLicense.lastName
                map["driverLicenseMiddleName"] = barcode.driverLicense.middleName
                map["driverLicenseLicenseNumber"] = barcode.driverLicense.licenseNumber
            }

            // Email
            Barcode.TYPE_EMAIL -> {
                map["emailAddress"] = barcode.email.address
                map["emailBody"] = barcode.email.body
                map["emailSubject"] = barcode.email.subject
                map["emailType"] = barcode.email.type
            }

            // Geo
            Barcode.TYPE_GEO -> {
                map["locationLatitude"] = barcode.geoPoint.lat
                map["locationLongitude"] = barcode.geoPoint.lng
            }

            // Phone
            Barcode.TYPE_PHONE -> {
                map["phoneNumber"] = barcode.phone.number
                map["phoneType"] = barcode.phone.type
            }

            // Sms
            Barcode.TYPE_SMS -> {
                map["smsMessage"] = barcode.sms.message
                map["smsPhoneNumber"] = barcode.sms.phoneNumber
            }

            // Url
            Barcode.TYPE_URL -> {
                map["urlTitle"] = barcode.url.title
                map["urlUrl"] = barcode.url.url
            }

            // Wifi
            Barcode.TYPE_WIFI -> {
                map["wifiSsid"] = barcode.wifi.ssid
                map["wifiEncryptionType"] = barcode.wifi.encryptionType
                map["wifiPassword"] = barcode.wifi.password
            }
        }

        return JSONObject(map.toMap())
    }

}